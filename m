From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 7 Aug 2017 08:20:53 +0200
Subject: [PATCH 2/5] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
In-Reply-To: <20170807040300.GC7516@nazgul.tnic>
References: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
 <00da9d8dcdbc95c170a9b52abcc2580c271bdd9d.1501848023.git.michal.simek@xilinx.com>
 <20170807040300.GC7516@nazgul.tnic>
Message-ID: <14045ee2-6da2-c0f2-55a2-b2dfd742c811@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7.8.2017 06:03, Borislav Petkov wrote:
> On Fri, Aug 04, 2017 at 02:00:24PM +0200, Michal Simek wrote:
>> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>>
>> This patch adds EDAC ECC support for ZynqMP DDRC IP
>>
>> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/edac/Kconfig         |   2 +-
>>  drivers/edac/synopsys_edac.c | 306 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 302 insertions(+), 6 deletions(-)
> 
> ...
> 
>> @@ -440,9 +706,12 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>>  	mci->dev_name = SYNPS_EDAC_MOD_STRING;
>>  	mci->mod_name = SYNPS_EDAC_MOD_VER;
>>  	mci->mod_ver = "1";
>> -
>> -	edac_op_state = EDAC_OPSTATE_POLL;
>> -	mci->edac_check = synps_edac_check;
>> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
>> +		edac_op_state = EDAC_OPSTATE_INT;
>> +	} else {
>> +		edac_op_state = EDAC_OPSTATE_POLL;
>> +		mci->edac_check = synps_edac_check;
>> +	}
>>  	mci->ctl_page_to_phys = NULL;
>>  
>>  	status = synps_edac_init_csrows(mci);
> 
> This hunk doesn't apply cleanly:
> 
> $ test-apply.sh -q /tmp/02-edac-synopsys-add_edac_ecc_support_for_zynqmp_ddrc.patch 
> checking file drivers/edac/Kconfig
> checking file drivers/edac/synopsys_edac.c
> Hunk #11 FAILED at 706.
> Hunk #12 succeeded at 723 (offset -1 lines).
> Hunk #13 succeeded at 754 (offset -1 lines).
> Hunk #14 succeeded at 803 (offset -1 lines).
> 1 out of 14 hunks FAILED
> 
> Please redo your patches against this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next
> 

The patch "EDAC: Get rid of mci->mod_ver" is causing that collision.
Will fix.



> Thx.
> 
>> @@ -458,8 +727,18 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>>  	.quirks				= 0,
>>  };
>>  
>> +static const struct synps_platform_data zynqmp_enh_edac_def = {
>> +	.synps_edac_geterror_info	= synps_enh_edac_geterror_info,
>> +	.synps_edac_get_mtype		= synps_enh_edac_get_mtype,
>> +	.synps_edac_get_dtype		= synps_enh_edac_get_dtype,
>> +	.synps_edac_get_eccstate	= synps_enh_edac_get_eccstate,
>> +	.quirks				= DDR_ECC_INTR_SUPPORT,
>> +};
>> +
>>  static const struct of_device_id synps_edac_match[] = {
>>  	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
>> +	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
>> +				.data = (void *)&zynqmp_enh_edac_def},
> 
> WARNING: DT compatible string "xlnx,zynqmp-ddrc-2.40a" appears un-documented -- check ./Documentation/devicetree/bindings/
> #414: FILE: drivers/edac/synopsys_edac.c:740:
> +       { .compatible = "xlnx,zynqmp-ddrc-2.40a",
> 
> Please integrate checkpatch.pl into your patch creation workflow.
> 

Thanks,
Michal
