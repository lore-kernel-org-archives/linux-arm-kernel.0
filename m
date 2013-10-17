From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Thu, 17 Oct 2013 21:09:38 +0300
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <1382012243.19506.19.camel@linaro1.home>
References: <525DC3D1.5030300@linaro.org>
 <1382012243.19506.19.camel@linaro1.home>
Message-ID: <526027E2.3000807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 03:17 PM, Jon Medhurst (Tixy) wrote:
> On Wed, 2013-10-16 at 01:38 +0300, Taras Kondratiuk wrote:
>> - Explicit filling with 0's (.align , 0) fixes the issue, but as a side
>>     effect data @0x4 is interpreted as a single ".word 0xaa000000"
>>     instead of ".byte .byte .short". I'm not sure if there can be any
>>     functional difference because of this.
> 
> After thinking about things overnight, I believe that this is the fix we
> should go with. We want to stick alignment padding between data laid
> down with .byte and .word so it makes sense to explicitly ask the
> toolchain to pad with zeros rather than leaving it the opportunity to
> get confused. (.align in the text section probably means it wants to
> align with nops, but then sees the initial alignment and/or surrounding
> statements look like binary data, not code, and then...)
> 
> I'll send a patch proposing that fix after I've worked out how to test
> it on a big-endian kernel. Or if someone else sends a patch for that
> with a good commit message that explains what's going on I'll happily
> ack that.

I have several fixes for BE Thumb kprobes on top of Ben's series.
".aling , 0" workaround is one of them.
All tests now pass for LE/BE and Thumb/ARM. I will clean up patches and
send them to Ben.
