From: adrian.wenl@gmail.com (Lei Wen)
Date: Sun, 13 Feb 2011 23:46:05 +0800
Subject: [PATCH V3 2/6] pxa3xx_nand: rework irq logic
In-Reply-To: <AANLkTinPyB-gUQg00kFg6SnsCpnfJRcD2PtgwfkjrUUh@mail.gmail.com>
References: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
	<1287742484-4276-3-git-send-email-leiwen@marvell.com>
	<AANLkTinPyB-gUQg00kFg6SnsCpnfJRcD2PtgwfkjrUUh@mail.gmail.com>
Message-ID: <AANLkTikRp4mdcAcGPaJ8QVXOcYMvUOA5g6azhCSYXn9M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sun, Feb 13, 2011 at 5:46 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Hi Lei,
>
> I like this idea very much. There are several places for improvement,
> though, you mind take a look?
>
>> ?static int pxa3xx_nand_dev_ready(struct mtd_info *mtd)
>> @@ -580,14 +582,12 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
>> ?{
>> ? ? ? ?struct pxa3xx_nand_info *info = mtd->priv;
>> ? ? ? ?const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
>> - ? ? ? int ret;
>> + ? ? ? int ret, exec_cmd = 0;
>>
>> ? ? ? ?info->use_dma = (use_dma) ? 1 : 0;
>> ? ? ? ?info->use_ecc = 0;
>> ? ? ? ?info->data_size = 0;
>> - ? ? ? info->state = STATE_READY;
>> -
>> - ? ? ? init_completion(&info->cmd_complete);
>> + ? ? ? info->state = 0;
>>
>> ? ? ? ?switch (command) {
>> ? ? ? ?case NAND_CMD_READOOB:
>> @@ -596,14 +596,12 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
>> ? ? ? ? ? ? ? ?info->buf_start = mtd->writesize + column;
>> ? ? ? ? ? ? ? ?memset(info->data_buff, 0xFF, info->buf_count);
>>
>> - ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset->read1, column, page_addr))
>> - ? ? ? ? ? ? ? ? ? ? ? break;
>> -
>> - ? ? ? ? ? ? ? pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
>> -
>> + ? ? ? ? ? ? ? prepare_read_prog_cmd(info, cmdset->read1, column, page_addr);
>> ? ? ? ? ? ? ? ?/* We only are OOB, so if the data has error, does not matter */
>> ? ? ? ? ? ? ? ?if (info->retcode == ERR_DBERR)
>> ? ? ? ? ? ? ? ? ? ? ? ?info->retcode = ERR_NONE;
>
> Note the above statement is executed after a do_cmd() is done, so
> info->retcode contains a valid return code. While the actual code
> to perform the command has been moved to below.

It is my fault not delete those line here...
In my following 0004 patch, I would unify the prepare step into one function.
BTW, for OOB data, I think we also shouldn't omit the DB error.
Like BCH crc algorithm, it also protect the oob area, so it is reasonable to
be aware that area...
>
> For each transaction, there are three steps:
>
> ?1. prepare/fill the command
> ?2. perform the command
> ?3. handle the return status
>
> I actually though of merging steps 2) and 3) together, but step
> 3) could be different, and that the timeout for different type of
> commands might be different, that's why I introduced the do_cmd()
> function.

I agree. :)
That is what I want to do in this patch set, unify the prepare behavior
into one function, and then execute it.

>
>> +
>> + ? ? ? ? ? ? ? exec_cmd = 1;
>
> Maybe for those cases where commands are not executed, just simply
> return will avoid introducing this exec_cmd variable.

For I unify the prepare process into one function according to different
command, simply return would be unable to notify the execute action...
The exec_cmd would be made as the return value for the prepare function.

>
> .....
>
>> @@ -807,10 +795,7 @@ static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
>> ? ? ? ?uint32_t ndcr;
>> ? ? ? ?uint8_t ?id_buff[8];
>>
>
> I saw __readid() is replaced by pxa3xx_nand_cmdfunc(NAND_CMD_READID)
> in the code below. ?Is it possible to completely remove this function
> now??

I made the remove behavior in the patch 0003. :)

Thanks,
Lei
