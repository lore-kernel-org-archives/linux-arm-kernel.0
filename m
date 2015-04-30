From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 10:45:50 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <4411194.KCIZ9l536O@wuerfel>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <CAL_JsqL8UnDco14Z8H7ZcxS=fLNiYgSb6ivv=zzpVctiD0FptA@mail.gmail.com>
 <20150430082051.GA3488@pd.tnic> <4411194.KCIZ9l536O@wuerfel>
Message-ID: <20150430084549.GB3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 10:31:12AM +0200, Arnd Bergmann wrote:
> The problem with your approach is that a lot of these blocks are not
> vendor specific. You will probably see a server chip that contains a
> memory controller from DesignWare, a cache controller from ARM, and
> some other device from the chip vendor, and each of them comes with
> EDAC support. Then you get three other vendors that have various
> combinations of the same memory controller, cache controller and
> other EDAC devices. Not all of these chips would have ARM CPU cores,
> some may be e.g. MIPS or PowerPC.

I don't mean system-vendor specific but IP-block vendor specific. So
doing a designware-edac, arm-edac, apm-edac and so on...

Also, I really want for people thinking of writing EDAC drivers to think
hard before doing so. Whether it is even worth to expose *every* RAS
functionality in some driver. And to consider that exposing it might
cause more trouble than benefit.

We've had that experience on x86 with reporting innocuous DRAM ECC
errors which were corrected by the hardware. People weren't even reading
the error message and running around wanting to RMA their processors
because something in dmesg screamed "Hardware Error".

And now APEI does the firmware-first thing where it gets to look at the
error first and then decide to report it up to the OS or not.

Which is a good thing because in most cases it unnecessarily upsets the
user.

So to get back on track: I think having the IP-block vendor stuff in one
EDAC module would make this whole heterogeneity much more manageable.

On that system above, we will load - if I can count correctly - 6 EDAC
drivers anyway. But the EDAC pile would remain sane.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
