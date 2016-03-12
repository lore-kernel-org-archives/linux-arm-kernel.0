From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sat, 12 Mar 2016 08:41:07 -0500
Subject: [linux-sunxi] GSoC 2014 #1 status report - Improving Allwinner
 SoC support
In-Reply-To: <CAGb2v655fUaEf=fqhTAkdiDtRN9h9drsFtMiWDv79biQC-vCTw@mail.gmail.com>
References: <53BE0B4F.1090001@elopez.com.ar> <53CAC9ED.9080302@elopez.com.ar>
 <CAGb2v67YZVnY1869uau_R7MGKGW2EeS2P0qtN0TX_0Uan-aRNw@mail.gmail.com>
 <CAGb2v679RqNj4FhT=T5Wx64My6ckDD0Eeq_5aVPh6zz9ei8+rQ@mail.gmail.com>
 <53CF4503.9010000@free.fr>
 <CAGb2v655fUaEf=fqhTAkdiDtRN9h9drsFtMiWDv79biQC-vCTw@mail.gmail.com>
Message-ID: <CAKON4Owup+zT6YS9b24u1SO49g1yGWQOO-FriuMf+ZUOr-pWMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So a long later I think I might have stumbled onto the explanation for
this in the Freescale ASOC driver (fsl_dma.c).

/**
 * fsl_dma_hw_params: continue initializing the DMA links
 *
 * This function obtains hardware parameters about the opened stream and
 * programs the DMA controller accordingly.
 *
 * One drawback of big-endian is that when copying integers of different
 * sizes to a fixed-sized register, the address to which the integer must be
 * copied is dependent on the size of the integer.
 *
 * For example, if P is the address of a 32-bit register, and X is a 32-bit
 * integer, then X should be copied to address P.  However, if X is a 16-bit
 * integer, then it should be copied to P+2.  If X is an 8-bit register,
 * then it should be copied to P+3.
 *
 * So for playback of 8-bit samples, the DMA controller must transfer single
 * bytes from the DMA buffer to the last byte of the STX0 register, i.e.
 * offset by 3 bytes. For 16-bit samples, the offset is two bytes.
 *
 * For 24-bit samples, the offset is 1 byte.  However, the DMA controller
 * does not support 3-byte copies (the DAHTS register supports only 1, 2, 4,
 * and 8 bytes at a time).  So we do not support packed 24-bit samples.
 * 24-bit data must be padded to 32 bits.
 */

/* Due to a quirk of the SSI's STX register, the target address
* for the DMA operations depends on the sample size.  So we calculate
* that offset here.  While we're at it, also tell the DMA controller
* how much data to transfer per sample.
*/
switch (sample_bits) {
case 8:
mr |= CCSR_DMA_MR_DAHTS_1 | CCSR_DMA_MR_SAHTS_1;
ssi_sxx_phys += 3;
break;
case 16:
mr |= CCSR_DMA_MR_DAHTS_2 | CCSR_DMA_MR_SAHTS_2;
ssi_sxx_phys += 2;
break;
case 32:
mr |= CCSR_DMA_MR_DAHTS_4 | CCSR_DMA_MR_SAHTS_4;
break;
default:
/* We should never get here */
dev_err(dev, "unsupported sample size %u\n", sample_bits);
return -EINVAL;
}



On Wed, Jul 23, 2014 at 1:19 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Wed, Jul 23, 2014 at 1:15 PM, Chris Moore <moore@free.fr> wrote:
>> Le 22/07/2014 12:22, Chen-Yu Tsai a ?crit :
>>
>>> So the user manual says that 24 bit samples should be right justified,
>>> or in the most significant bytes.
>>
>> I understand "right justified" to mean "in the *least* significant bits".
>
> Ah yes. Pardon me. Sticking to "most significant bits" is better. :)
>
>
> ChenYu
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl at gmail.com
