From: william76.sh@gmail.com (William F.)
Date: Tue, 26 Jun 2012 11:37:18 -0300
Subject: [PATCH v11 4/4] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller (REPORT SPAM)
In-Reply-To: <CACQ1gAhQDbpogep=fTM-odO0XDHXJGn3uWHx7FP7Ywjt+7tzMw@mail.gmail.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340618866-28776-5-git-send-email-josh.wu@atmel.com>
 <CACQ1gAhQDbpogep=fTM-odO0XDHXJGn3uWHx7FP7Ywjt+7tzMw@mail.gmail.com>
Message-ID: <4FE9C91E.9040804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 26-06-2012 11:15, Richard Genoud escreveu:
> 2012/6/25 Josh Wu<josh.wu@atmel.com>:
>> +static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf,
>> +               int extra_bytes, int err_nbr)
>> +{
>> +       struct nand_chip *nand_chip = mtd->priv;
>> +       struct atmel_nand_host *host = nand_chip->priv;
>> +       int i = 0;
>> +       int byte_pos, bit_pos, sector_size, ecc_size;
>> +       uint32_t tmp;
>> +
>> +       sector_size = host->pmecc_sector_size;
>> +       ecc_size = nand_chip->ecc.bytes;
>> +
>> +       while (err_nbr) {
>> +               tmp = pmerrloc_readl_el_relaxed(host->pmerrloc_base, i) - 1;
>> +               byte_pos = tmp / 8;
>> +               bit_pos  = tmp % 8;
>> +               dev_info(host->dev, "PMECC correction, byte_pos: %d bit_pos: %d\n",
>> +                                       byte_pos, bit_pos);
>> +
>> +               if (byte_pos<  (sector_size + extra_bytes)) {
>> +                       tmp = sector_size +
>> +                               pmecc_readl_relaxed(host->ecc, SADDR);
>> +
>> +                       if (byte_pos<  tmp)
>> +                               *(buf + byte_pos) ^= (1<<  bit_pos);
>> +                       else
>> +                               *(buf + byte_pos + ecc_size) ^= (1<<  bit_pos);
>> +               }
> I think there's a problem in there.
> On my board (sam9g35-ek), I've got 2KB pages and 4 sectors per page + 64B OOB.
> When I flip a bit on the 63rd OOB byte (the last ECC byte), byte_pos is 515.
> If I flip a bit on the 51th OOB byte (the 3rd ECC byte), byte_pos is also 515.
> So, if I get it correct, byte_pos will always be between 0 and
> sector_size + sector_ecc_bytes.
> (and I think that sector_ecc_bytes == extra_bytes (cf below))
> And, pmecc_readl_relaxed(host->ecc, SADDR) gives me the ECC offset in OOB (48).
> So, (byte_pos<  sector_size + extra_bytes) will always be correct as
> far as the PMECC controller doesn't give us crap.
> But, IHMO the "tmp = sector_size + pmecc_readl_relaxed(host->ecc,
> SADDR);" line is wrong.
>
> I think that it should be something like this:
> static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf, uint8_t *ecc,
> 		int extra_bytes, int err_nbr, int sector_number)
> {
> [...]
> 		tmp = pmerrloc_readl_el_relaxed(host->pmerrloc_base, i) - 1;
> 		byte_pos = tmp / 8;
> 		bit_pos  = tmp % 8;
> 		if (byte_pos<  (sector_size + extra_bytes)) {
> 			if (byte_pos<  sector_size) {
> 				*(buf + byte_pos) ^= (1<<  bit_pos);
> 				/* It may be easier to read this info if the byte_pos
> 				 * is relative to the page start, not just the sector */
> 				dev_info(host->dev, "PMECC correction, byte_pos: %d bit_pos: %d\n",
> 					 sector_number * sector_sz + byte_pos, bit_pos);
> 			} else {
> 				/* number of ecc bytes per sector */
> 				tmp = pmecc_get_ecc_bytes(nand_chip->ecc.strength, sector_size);
> 				/* offset in the ecc of the ecc bytes for current sector */
> 				tmp *= sector_number;
> 				/* now, tmp is the offset of the byte error in the ecc */
> 				tmp += byte_pos - sector_size;
> 				ecc[tmp] ^= (1<<  bit_pos);
> 				dev_info(host->dev, "Bit flip in ECC, ecc_byte_pos: %d bit_pos: %d\n",
> 					 tmp, bit_pos);
> 				/* or */
> 				dev_info(host->dev, "Bit flip in OOB, oob_byte_pos: %d bit_pos: %d\n",
> 					 tmp + nand_chip->ecc_layout.eccpos[0], bit_pos);
> 			}
> 		}
> [...]
>
>> +
>> +               i++;
>> +               err_nbr--;
>> +       }
>> +
>> +       return;
>> +}
>> +
>> +static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
>> +       u8 *ecc)
>> +{
>> +       struct nand_chip *nand_chip = mtd->priv;
>> +       struct atmel_nand_host *host = nand_chip->priv;
>> +       int i, err_nbr, eccbytes;
>> +       uint8_t *buf_pos;
>> +
>> +       eccbytes = nand_chip->ecc.bytes;
>> +       for (i = 0; i<  eccbytes; i++)
>> +               if (ecc[i] != 0xff)
>> +                       goto normal_check;
>> +       /* Erased page, return OK */
>> +       return 0;
>> +
>> +normal_check:
>> +       for (i = 0; i<  host->pmecc_sector_number; i++) {
>> +               err_nbr = 0;
>> +               if (pmecc_stat&  0x1) {
>> +                       buf_pos = buf + i * host->pmecc_sector_size;
>> +
>> +                       pmecc_gen_syndrome(mtd, i);
>> +                       pmecc_substitute(mtd);
>> +                       pmecc_get_sigma(mtd);
>> +
>> +                       err_nbr = pmecc_err_location(mtd);
>> +                       if (err_nbr == -1) {
>> +                               dev_err(host->dev, "PMECC: Too many errors\n");
>> +                               mtd->ecc_stats.failed++;
>> +                               return -EIO;
>> +                       } else {
>> +                               pmecc_correct_data(mtd, buf_pos, 0, err_nbr);
> IHMO, extra_bytes should be (eccbytes / host->pmecc_sector_number)
> pmecc_correct_data(mtd, buf_pos, ecc, eccbytes /
> host->pmecc_sector_number, err_nbr, i);
>
>> +                               mtd->ecc_stats.corrected += err_nbr;
>> +                       }
>> +               }
>> +               pmecc_stat>>= 1;
>> +       }
>> +
>> +       return 0;
>> +}
> I tested the patchset against 3.5-rc4, on a at91sam9g35-ek board.
> the DTS config I used is:
> reg =<0x40000000 0x10000000 0xffffe000 0x600 0xffffe600 0x200
> 0x00100000 0x00100000>;
> nand-bus-width =<8>;
> nand-ecc-mode = "hw";
> nand-on-flash-bbt;
> atmel,nand-addr-offset =<21>;
> atmel,nand-cmd-offset =<22>;
> gpios =<&pioD 5 0&pioD 4 0 0>;
> atmel,has-pmecc;
> atmel,pmecc-cap =<2>;
> atmel,pmecc-sector-size =<512>;
> atmel,pmecc-lookup-table-offset =<0x8000 0x10000>;
>
> (nand on the -ek is 2KiB page size, 128KiB eraseblock)
>
> I tested
> - 1 bit flip on a page
> - 4 bit flips on a page (1 per sector)
> - 5 bit flips on a page (2 on sector 1, and then 1 per sector)
> - 1 bit flip on ECC
> - 2 bit flips on ECC (on the same byte)
> - 3 bit flips =>  I/O error (ok, since pmecc-cap = 2 )
> - 3 bit flips on ECC =>  I/O error (ok, since pmecc-cap = 2 )
> only problem : ECC is not corrected (should be better with the fixes above)
>
> When you have corrected the ECC correction issue, you can add my:
> Tested-by: Richard Genoud<richard.genoud@gmail.com>
>
> Regards.
