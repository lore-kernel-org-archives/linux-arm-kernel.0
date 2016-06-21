From: loic.pallardy@st.com (loic pallardy)
Date: Tue, 21 Jun 2016 09:33:39 +0200
Subject: [STLinux Kernel] [PATCH 4/5] remoteproc: core: Supply framework
 to request, declare and fetch shared memory
In-Reply-To: <20160615220629.GW1256@tuxbot>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
 <20160615220629.GW1256@tuxbot>
Message-ID: <5768EDD3.3050203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/16/2016 12:06 AM, Bjorn Andersson wrote:
> On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
>
>> Normally used for management of; carveout, devmem and trace memory.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 174 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 167 insertions(+), 7 deletions(-)
>>
[..]
>> +}
>> +EXPORT_SYMBOL(rproc_subdev_add);
>
Hi Bjorn,

> I worked up a prototype that allows remoteproc drivers to
> programmatically specify carveout resources, which then are matched and
> merged with entires from the resource table. I've given these
> programmatically allocated carveouts a device so that the associated
> allocation comes out of the specified region - or the rproc region if no
> match is found.
>
No sure to catch your exact use case, but let me try to explain what we 
have today.
There are different rproc in ST. Some request a large chunk of memory 
for code and data, some have several dedicated memories like IRAM and DRAM.
In that case carevout memories are defined as subdev (like vrings).
Association is done thanks to carevout name in firmware resource table 
(in rproc_handle_carveout).

Moreover, as our coprocessors have no iommu, we add some check on 
allocated buffer to verify it fit with resource table declaration (pa).
This allows to guarantee complete alignment between resources needed by 
firmware and ones allocated by Linux kernel.
>
> This solves my use case of carving out memory from two disjoint memory
> regions for one of my remoteprocs, but differs from your approach in
> that you specify one large carveout (and vrings) region and any
> carveouts (or vrings) will chip away from this.
>
> Would this approach work for you, or do you depend on having 1:N
> relationship between your memory region and your resources?
>

Is this approach covering your needs?

Regards,
Loic

> Regards,
> Bjorn
>
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
>
