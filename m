From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 5 Mar 2012 00:13:52 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120305000411.GL7363@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
Message-ID: <4F54053F.9070502@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
>> Russell King - ARM Linux wrote:
>>> Is the SCR shared between capture and playback?  In that case, what
>>> makes this read-modify-write thread safe?
>>
>> What's "SCR"?
>
> I assumed you knew the code you were commenting on.
>
>                  clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
>
> The register these functions seem to be used on appears to be called
> 'SCR'.

Oh, I didn't know you were referencing a specific register on the part. 
There are multiple uses of clrsetbits_be32 (and its variants) in the function.

To answer your question: I was lead to believe that the individual ALSA 
callback functions are atomic.  So one thread should not be trying to 
start playback while another thread is simultaneously trying to stop it.

> Why do you say "can't" - what prevents it?  If nothing, then this stuff
> is buggy when preempt is enabled, or you're running on SMP.

Sorry, let me rephrase the sentence to be more clear.

"You can't have two threads attempt to initialize the hardware at the same 
time, and expect it to work."

Since I expect ALSA callback functions to be atomic, I'm not concerned 
about one two threads trying to use SCR at the same time.

-- 
Timur Tabi
Linux kernel developer at Freescale
