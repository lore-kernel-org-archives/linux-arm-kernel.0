From: vigneshr@ti.com (Vignesh R)
Date: Fri, 22 Dec 2017 15:18:53 +0530
Subject: [PATCH 2/2] mtd: spi-nor: cadence-quadspi: Add support for direct
 access mode
In-Reply-To: <82986b75-79a1-68da-efbd-aeb603b3d7be@wedev4u.fr>
References: <20171207063804.29436-1-vigneshr@ti.com>
 <20171207063804.29436-3-vigneshr@ti.com>
 <82986b75-79a1-68da-efbd-aeb603b3d7be@wedev4u.fr>
Message-ID: <2922f743-406a-ef2e-66b5-a37666381112@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille

On Wednesday 20 December 2017 08:43 PM, Cyrille Pitchen wrote:
> Hi Vignesh,
> 
> Le 07/12/2017 ? 07:38, Vignesh R a ?crit :
>> Cadence QSPI controller provides direct access mode through which flash
>> can be accessed in a memory-mapped IO mode. This enables read/write to
>> flash using memcpy*() functions. This mode provides higher throughput
>> for both read/write operations when compared to current indirect mode of
>> operation.
>> 
>> This patch therefore adds support to use QSPI in direct mode. If the
>> window reserved in SoC's memory map for MMIO access is less that of
>> flash size(like on most SoCFPGA variants), then the driver falls back
>> to indirect mode of operation.
>> 
>> On TI's 66AK2G SoC, with ARM running at 600MHz and QSPI at 96MHz
>> switching to direct mode improves read throughput from 3MB/s to 8MB/s.
>> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---

[...]

>> +static int cqspi_direct_read_execute(struct spi_nor *nor, u8 *rxbuf,
>> +????????????????????????????????? loff_t from_addr, const size_t len)
>> +{
>> +???? struct cqspi_flash_pdata *f_pdata = nor->priv;
>> +???? struct cqspi_st *cqspi = f_pdata->cqspi;
>> +???? u32 reg;
>> +
>> +???? reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +???? reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +???? writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> 
> I guess setting the ENB_DIR_ACC_CTRL bit could be set once for all when you
> set use_direct_mode to true, couldn't it?
> 
> It may improve the read performance even more. However not expecting much
> difference for Page Program operations.
> 
> Then you could call directly call mempcy_fromio() from cqspi_read().
> Not mandatory for me, since I also like the symmetry of the 2 functions:
> cqspi_direct_read_execute() / cqspi_indirect_read_execute().
> 

Right, actually I can unconditionally set ENB_DIR_ACC_CTRL once in
cqspi_controller_init(). Indirect accesses will still be forwarded to
indirect access controller even if direct access controller is kept
enabled. So, indirect ops users are not affected.
I will make the changes in v2.

> So it's up to you :)
> 
>> +???? memcpy_fromio(rxbuf, cqspi->ahb_base + from_addr, len);
>> +
>> +???? return 0;
>> +}
>> +
>>? static int cqspi_write_setup(struct spi_nor *nor)
>>? {
>>??????? unsigned int reg;
>> @@ -671,6 +689,21 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>>??????? return ret;
>>? }
>>? 
>> +static int cqspi_direct_write_execute(struct spi_nor *nor, loff_t to_addr,
>> +?????????????????????????????????? const u8 *txbuf, const size_t len)
>> +{
>> +???? struct cqspi_flash_pdata *f_pdata = nor->priv;
>> +???? struct cqspi_st *cqspi = f_pdata->cqspi;
>> +???? u32 reg;
>> +
>> +???? reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +???? reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +???? writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> 
> Same comment here.
> 
>> +???? memcpy_toio(cqspi->ahb_base + to_addr, txbuf, len);
>> +
>> +???? return 0;
>> +}
>> +
>>? static void cqspi_chipselect(struct spi_nor *nor)
>>? {
>>??????? struct cqspi_flash_pdata *f_pdata = nor->priv;
>> @@ -891,6 +924,7 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>>? static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>>?????????????????????????? size_t len, const u_char *buf)
>>? {
>> +???? struct cqspi_flash_pdata *f_pdata = nor->priv;
>>??????? int ret;
>>? 
>>??????? ret = cqspi_set_protocol(nor, 0);
>> @@ -901,7 +935,10 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>>??????? if (ret)
>>??????????????? return ret;
>>? 
>> -???? ret = cqspi_indirect_write_execute(nor, to, buf, len);
>> +???? if (f_pdata->use_direct_mode)
>> +???????????? ret = cqspi_direct_write_execute(nor, to, buf, len);
>> +???? else
>> +???????????? ret = cqspi_indirect_write_execute(nor, to, buf, len);
>>??????? if (ret)
>>??????????????? return ret;
>>? 
>> @@ -911,6 +948,7 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>>? static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>>????????????????????????? size_t len, u_char *buf)
>>? {
>> +???? struct cqspi_flash_pdata *f_pdata = nor->priv;
>>??????? int ret;
>>? 
>>??????? ret = cqspi_set_protocol(nor, 1);
>> @@ -921,7 +959,10 @@ static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>>??????? if (ret)
>>??????????????? return ret;
>>? 
>> -???? ret = cqspi_indirect_read_execute(nor, buf, from, len);
>> +???? if (f_pdata->use_direct_mode)
>> +???????????? ret = cqspi_direct_read_execute(nor, buf, from, len);
>> +???? else
>> +???????????? ret = cqspi_indirect_read_execute(nor, buf, from, len);
>>??????? if (ret)
>>??????????????? return ret;
>>? 
>> @@ -1153,6 +1194,12 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>??????????????????????? goto err;
>>? 
>>??????????????? f_pdata->registered = true;
>> +
>> +???????????? if (mtd->size <= cqspi->ahb_size) {
>> +???????????????????? f_pdata->use_direct_mode = true;
>> +???????????????????? dev_info(nor->dev, "using direct mode for %s\n",
>> +????????????????????????????? mtd->name);
> 
> Please use dev_dbg() here insted of dev_info(). IMHO, this kind of output
> is not really needed by regular users.
> 

Agreed, will update that.

> Otherwise, the series looks great!
> 

Thanks for the review! Will submit v2 shortly.


-- 
Regards
Vignesh
