From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 18 Feb 2015 11:06:22 -0300
Subject: [PATCH v4 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <20150218140143.GQ25269@lukather>
References: <1424255528-1717-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424255528-1717-2-git-send-email-maxime.ripard@free-electrons.com>
 <54E49632.1000001@free-electrons.com> <20150218140143.GQ25269@lukather>
Message-ID: <54E49C5E.3090300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/18/2015 11:01 AM, Maxime Ripard wrote:
> On Wed, Feb 18, 2015 at 10:40:02AM -0300, Ezequiel Garcia wrote:
>> On 02/18/2015 07:32 AM, Maxime Ripard wrote:
>>> The NDDB register holds the data that are needed by the read
>>> and write commands.
>>> 
>>> However, during a read PIO access, the datasheet specifies that
>>> after each 32 bytes read in that register, when BCH is enabled,
>>> we have to make sure that the RDDREQ bit is set in the NDSR
>>> register.
>>> 
>>> This fixes an issue that was seen on the Armada 385, and
>>> presumably other mvebu SoCs, when a read on a newly erased page
>>> would end up in the driver reporting a timeout from the NAND.
>>> 
>>> Cc: <stable@vger.kernel.org> # v3.14 Signed-off-by: Maxime
>>> Ripard <maxime.ripard@free-electrons.com> --- 
>>> drivers/mtd/nand/pxa3xx_nand.c | 48
>>> ++++++++++++++++++++++++++++++++++++------ 1 file changed, 42
>>> insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c
>>> b/drivers/mtd/nand/pxa3xx_nand.c index
>>> 96b0b1d27df1..bc677362bc73 100644 ---
>>> a/drivers/mtd/nand/pxa3xx_nand.c +++
>>> b/drivers/mtd/nand/pxa3xx_nand.c @@ -480,6 +480,42 @@ static
>>> void disable_int(struct pxa3xx_nand_info *info, uint32_t
>>> int_mask) nand_writel(info, NDCR, ndcr | int_mask); }
>>> 
>>> +static void drain_fifo(struct pxa3xx_nand_info *info, void
>>> *data, int len) +{ +	if (info->ecc_bch) { +		int timeout; + +
>>> /* +		 * According to the datasheet, when reading from NDDB +
>>> * with BCH enabled, after each 32 bytes reads, we +		 * have to
>>> make sure that the NDSR.RDDREQ bit is set. +		 * +		 * Drain
>>> the FIFO 8 32 bits reads at a time, and skip +		 * the polling
>>> on the last read. +		 */ +		while (len > 8) { +
>>> __raw_readsl(info->mmio_base + NDDB, data, 8); + +			for
>>> (timeout = 0; +			     !(nand_readl(info, NDSR) &
>>> NDSR_RDDREQ); +			     timeout++) { +				if (timeout >= 5) { +
>>> dev_err(&info->pdev->dev, +						"Timeout on RDDREQ while
>>> draining the FIFO\n"); +					return; +				} + +				mdelay(1);
>> 
>> This is probably a stupid nit.. but here it goes is it any 
>> difference if udelay is used here?
>> 
>> Does this makes anything better/worse?
> 
> It doesn't make any difference. On the board I've been using, we
> never hit the delay.
> 
> So I really don't care about the number of retries and the sleep 
> behind them. I made these numbers up, feel free to come up with
> others if it makes you more comfortable, but could we settle this?
> 

OK, let's stop the bikeshedding. For both patches:

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
- -- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU5JxaAAoJEIOKbhOEIHKi9HYP/jxU75zI6QjNk1yGL7Y3qwEy
M2UYrepXTwgRVRxAIN3nhGqERuBVOJCIVKlb3CUSiq9auNAO8rsRs6JTAossV781
LTUniAA0nIBFbTn/k2Wc6yGQizSy7iJRXu73MrLJrcSFO8JxFFqu04V1EYuZbh5s
fuVpeLJEX8Gfy6gj85ybFs7+wkD/XnENKlnDzD6y/n4ewBC3yDPLNh436hZpEVDO
ky8lYjGPHMQs0yEDcp1rfFejLAmxJ4SY6hVSKAxq3/Bn58S4y3Pgkm4cJtP8nHYe
UN4q9UfOBIHWrQIVbBlViK//n3zyEtaPojDSKUiSvI2+Hmz9+eortlYEvpN1HCP3
Xqy1gzFto9FpP4Wp3KpyF609JNVUeQxAsUQZMXM6yaH2oz35szZhBq2xlIpsyo3C
BDbjaYKFk3hVg+jAE0iitZW8BiZS+WZ/pzX4A8rwQBSTMcbrLTuRV611R4E/nEBL
sfCwDWc1gxDDiM8pMJBGC97gwtHEibJqxES9y+T3LrhxtqPl1kUczHFDPgd3uoVw
fT71PsZBtGUeOu3ysymNPc+mF9b9G9KRHYhSiOjnEIle9yvXh6kaGWv93ZM3RCUG
JASv01+gqb+Bz5ZU3MMU+xjHxeoWBq7KfSWcshEHpD8QCuiZzNZ3yt0dZaYXao+M
YsLlm5s62fDVILb2Q3+d
=MA8V
-----END PGP SIGNATURE-----
