From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Tue, 3 Jan 2017 13:51:03 +0000
Subject: [PATCH v2 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A66012C@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1482483135-14767-1-git-send-email-appanad@xilinx.com>
 <1482483135-14767-3-git-send-email-appanad@xilinx.com>
 <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A65FFE9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <45807619-bf6a-0174-c102-12c03aeb575c@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A66012C@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <a8f5c216-cac0-daf9-a880-3820ae9b5e13@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,


On 02-01-2017 16:00, Appana Durga Kedareswara Rao wrote:
> Hi Jose Miguel Abreu,
>
> 	Thanks for the review...
>
> [snip]...
>> I just noticed there is a write to XILINX_DMA_REG_FRMSTORE which, by the
>> description in the VDMA databook, allows to modify the total number of
>> framebuffers.
>>
>> Does it correct this situation: Lets assume VDMA has 10 framebuffers in HW and
>> user only submits 5 descriptors. Then vsize will be programmed and VDMA will
>> start. The VDMA will start in fb 1, then 2, ... until 5 its all ok. But then after the fb
>> 5 the VDMA will jump to fb 6, this fb will have no address because the user only
>> submitted 5 addresses so VDMA will try to write to location 0x0 of system mem
>> (if using S2MM channel). ?
>>
>> If so then there is no race condition, but the HW image that I have does not
>> have this register enabled so I was getting this result (memory corruption
>> because not all framebuffers had addresses set).
> Thanks for the explanation. 
> Agree the issue that you mentioned won't come when XILINX_DMA_REG_FRMSTORE
> (C_ENABLE_DEBUG_INFO_5 and C_ENABLE_DEBUG_INFO_13) Register is enabled in the IP.
> But this register won't get enabled with the default IP configuration (C_ENABLE_DEBUG_INFO_5 and C_ENABLE_DEBUG_INFO_13).
>
> When user is not enabled XILINX_DMA_REG_FRMSTORE in the h/w and submits frames less than h/w capable.
> The solution that I am thinking is to throw an error in the driver saying that either enable the
> num frame store feature in the IP or submit the frames up to h/w capable what do you think???

Sounds fine by me.

Best regards,
Jose Miguel Abreu

>
> Regards,
> Kedar.
>
>> Best regards,
>> Jose Miguel Abreu
>>
>>> Regards,
>>> Kedar.
>>>
>>>> Best regards,
>>>> Jose Miguel Abreu
>>>>
