From: loic.pallardy@st.com (loic pallardy)
Date: Fri, 17 Jun 2016 21:53:08 +0200
Subject: [STLinux Kernel] [PATCH 5/5] remoteproc: core: Clip carveout if
 it's too big
In-Reply-To: <20160510192129.GL1256@tuxbot>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-6-git-send-email-lee.jones@linaro.org>
 <20160510192129.GL1256@tuxbot>
Message-ID: <57645524.1030200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On 05/10/2016 09:21 PM, Bjorn Andersson wrote:
> On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
>
>> Carveout size is primarily extracted from the firmware binary.  However,
>> DT can over-ride this by providing a different (smaller) size.  We're
>> adding protection here to ensure the we only allocate the smaller of the
>> two provided sizes in order to decrease the risk of clashes.
>>
>
> Is this really the right thing to do?
>
> The firmware is bundled with a resource table stating a certain size of
> this the carveout and this would "silently" give it less space. On some
> systems an IOMMU will save us (killing the firmware) but on others I
> fear the firmware might just access memory outside its expected buffer.

Agree with Bjorn, not it is not possible to silently clip carveout 
memory.Firmware resource table should contain exact coprocessor needs. 
If resources are not available, firmware loading must failed with 
explicit message.

Regards,
Loic

>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> [..]
>> @@ -600,6 +601,14 @@ static int rproc_handle_carveout(struct rproc *rproc,
>>   		return -ENOMEM;
>>
>>   	dma_dev = rproc_subdev_lookup(rproc, "carveout");
>> +	sub = dev_get_drvdata(dma_dev);
>> +
>> +	if (rsc->len > resource_size(sub->res)) {
>> +		dev_warn(dev, "carveout too big (0x%x): clipping to 0x%x\n",
>> +			 rsc->len, resource_size(sub->res));
>> +		rsc->len = resource_size(sub->res);
>> +	}
>
> I would rather expect this to say:
>
> if (resource_size(sub->res) < rsc->len) {
> 	dev_err(dev, "defined carveout to small for firmware\n");
> 	return -EINVAL;
> }
>
> Unless we trust the remote firmware to dynamically follow what we put in
> the resource table. (And how does it tell us if that limit isn't
> enough?)
>
>> +
>>   	va = dma_alloc_coherent(dma_dev, rsc->len, &dma, GFP_KERNEL);
>>   	if (!va) {
>>   		dev_err(dev->parent, "dma_alloc_coherent err: %d\n", rsc->len);
>
>
> Apart from this concern I'm still need to review the subdev patch; here
> related the part that there's only room for one carveout with only one
> size.
>
> Regards,
> Bjorn
>
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
>
