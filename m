From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Mon, 2 Jan 2017 13:34:51 +0000
Subject: [PATCH v2 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A65FFE9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1482483135-14767-1-git-send-email-appanad@xilinx.com>
 <1482483135-14767-3-git-send-email-appanad@xilinx.com>
 <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A65FFE9@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <45807619-bf6a-0174-c102-12c03aeb575c@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,


On 02-01-2017 11:46, Appana Durga Kedareswara Rao wrote:
> Hi Jose Miguel Abreu,
> 	
> 	Thanks for the review....
> Sorry for the delay in the reply please see comments inline...
>
>>

[snip]

>> What if we reach here and j < num_frms? It can happen because if
>> the pending list is empty the loop breaks. Then VDMA will start
>> with framebuffers having address 0x0. You should only program
>> vsize when j > num_frms or when we have already previously set
>> the framebuffers (i.e. when submitcount has already been
>> incremented num_frms at least once).
> In case of j < num_frms VDMA won't start the frame buffer having address 0
> As we are programming the VDMA buffer address based on the desc_submitcount value only i.e. i.
>
> Code snippet in the driver doing this:
>                          list_for_each_entry(segment, &desc->segments, node) {
>                                 if (chan->ext_addr)
>                                         vdma_desc_write_64(chan,
>                                           XILINX_VDMA_REG_START_ADDRESS_64(i++),
>                                           segment->hw.buf_addr,
>                                           segment->hw.buf_addr_msb);
>                                 else
>                                         vdma_desc_write(chan,
>                                             XILINX_VDMA_REG_START_ADDRESS(i++),
>                                             segment->hw.buf_addr);
>
>                                 last = segment;
>                         } 
>
> Initially desc_submitcount will be zero.
> Let's assume h/w is configured for 10 frames and user submitted only 5 frames.
> And triggered the VDMA h/w using issue_pending in this case desc_submitcount will be 5.
> desc_submitcount will become zero again only when
> User submits more frames than h/w capable or user submit frames up to h/w capable.
>
> If my understanding is wrong could you please elaborate the race condition that you are talking above?

I just noticed there is a write to XILINX_DMA_REG_FRMSTORE which,
by the description in the VDMA databook, allows to modify the
total number of framebuffers.

Does it correct this situation: Lets assume VDMA has 10
framebuffers in HW and user only submits 5 descriptors. Then
vsize will be programmed and VDMA will start. The VDMA will start
in fb 1, then 2, ... until 5 its all ok. But then after the fb 5
the VDMA will jump to fb 6, this fb will have no address because
the user only submitted 5 addresses so VDMA will try to write to
location 0x0 of system mem (if using S2MM channel). ?

If so then there is no race condition, but the HW image that I
have does not have this register enabled so I was getting this
result (memory corruption because not all framebuffers had
addresses set).

Best regards,
Jose Miguel Abreu

> 	
> Regards,
> Kedar.
>
>> Best regards,
>> Jose Miguel Abreu
>>
