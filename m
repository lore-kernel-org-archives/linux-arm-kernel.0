From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 10:26:33 +0100
Subject: Massive log spam loading modules on ARM after 3.2-rc5 (regression)
In-Reply-To: <20111214215133.GA7780@elliptictech.com>
References: <20111214215133.GA7780@elliptictech.com>
Message-ID: <20111215092633.GD24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 04:51:33PM -0500, Nick Bowler wrote:
> Hi folks,
> 
> With latest Linus' master, I'm faced with massive log spam on our ARM
> Versatile Express platform when using modules.  Here's an example:
> 
>   # modprobe sp805-wdt
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   sp805-wdt mb:wdt: registration successful
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
>   unwind: Unknown symbol address 7f802009
>   unwind: Index not found 7f802009
> 
> The message only seem to get printed at module load time.  Other than
> the noise, things _seem_ to be working.  Nevertheless, it's a regression
> introduced after 3.2-rc5 by the following commit:
> 
>   de66a979012dbc66b1ec0125795a3f79ee667b8a is the first bad commit
>   commit de66a979012dbc66b1ec0125795a3f79ee667b8a
>   Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>   Date:   Mon Dec 5 09:39:59 2011 +0100
> 
>       ARM: 7187/1: fix unwinding for XIP kernels
> 
>       The linker places the unwind tables in readonly sections. So when using
>       an XIP kernel these are located in ROM and cannot be modified.
>       For that reason the current approach to convert the relative offsets in
>       the unwind index to absolute addresses early in the boot process doesn't
>       work with XIP.
> 
>       The offsets in the unwind index section are signed 31 bit numbers and
>       the structs are sorted by this offset. So it first has offsets between
>       0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
>       between 0x00000000 and 0x3fffffff. When seperating these two blocks the
>       numbers are sorted even when interpreting the offsets as unsigned longs.
> 
>       So determine the first non-negative entry once and track that using the
>       new origin pointer. The actual bisection can then use a plain unsigned
>       long comparison. The only thing that makes the new bisection more
>       complicated is that the offsets are relative to their position in the
>       index section, so the key to search needs to be adapted accordingly in
>       each step.
> 
>       Moreover several consts are added to catch future writes and rename the
>       member "addr" of struct unwind_idx to "addr_offset" to better match the
>       new semantic. (This has the additional benefit of breaking eventual
>       users at compile time to make them aware of the change.)
> 
>       In my tests the new algorithm was a tad faster than the original and has
>       the additional upside of not needing the initial conversion and so saves
>       some boot time and it's possible to unwind even earlier.
> 
>       Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>       Acked-by: Nicolas Pitre <nico@fluxnic.net>
>       Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>       Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
>   :040000 040000 9c4363228515808d71dac84a4a16e0aa0cf4ceaa 65b80d4e51fabf0a3142a880be795f4b38f4d9fe M	arch
> 
> I am *not* using XIP.  Reverting this commit resolves the issue.
> 
> Let me know if you need any more info,
Can you provide me your .config please? I cannot reproduce your problems
with modprobe on an i.MX28 based tx28 machine.

Russell, maybe this makes you a bit less annoyed?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
