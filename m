From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jun 2017 20:28:08 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170629124908.GV4902@n2100.armlinux.org.uk>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <20170629124908.GV4902@n2100.armlinux.org.uk>
Message-ID: <20170629145808.GQ29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-17, 13:49, Russell King - ARM Linux wrote:
> The thing that concerns me most about this is that typically the LCD
> controller will be performing DMA to system RAM.
> 
> The location of the frame buffer is unknown to the decompressor - and
> as the decompressor self-relocates itself (using purely assembly code),
> it could relocate itself on top of the frame buffer, causing the "nice"
> image to become very colourful.
> 
> The decompressor doesn't have the information from DT at that point to
> know what are safe locations, so it's up to the boot loader to place
> the frame buffer somewhere out of the way.  (If people want to write
> a DT parser in position independent ARM assembly code that may change.)
> 
> As long as people realise this, then it's not a problem, but given the
> number of problems that we've already encountered with boot loaders and
> memory space layout, I don't trust them to get this right.
> 
> Right now, the ARM kernel booting document requires:
> 
> - Quiesce all DMA capable devices so that memory does not get
>   corrupted by bogus network packets or disk data. This will save
>   you many hours of debug.
> 
> so we would need to modify that to make an exception for LCD controllers.
> However, we definitely can't have devices left enabled which are capable
> of writing to system memory, or which changing system memory is likely
> to cause bad effects (eg, packet ring buffers, USB buffers etc, which is
> really what the above requirement is about.)

Well, LCD was just an example here. But yeah, it is one of the most
probable case we have.

So, this thing is already working for sure, of course with some out of
tree hacks. Every smart phone shows their company's logo (some kind of
flash) while the phone boots. How do they get around such issues?

@Stephen: Any idea how Qcom does it ? :)

Must be fixing some area in RAM for this purpose, isn't it ?

-- 
viresh
