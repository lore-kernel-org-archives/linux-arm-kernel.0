From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 00:14:14 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <yw1x4mgfc89z.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6160413.CulAvzVaQj@wuerfel> <yw1x4mgfc89z.fsf@unicorn.mansr.com>
Message-ID: <4519802.lamVCN5F0B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 November 2015 22:11:36 M?ns Rullg?rd wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Saturday 21 November 2015 20:45:38 M?ns Rullg?rd wrote:
> >> On 21 November 2015 20:39:58 GMT+00:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >> 
> >> The ARM ARM says anything with virt has idiv, lpae doesn't matter.
> >
> > Ok, and anything with virt also has lpae by definition. The question is
> > whether we care about using idiv on cores that do not have lpae, or that
> > have neither lpae nor virt.
> 
> The question is, are there any such cores?  GCC doesn't know of any, but
> then it's missing most non-ARM designs.

Exactly. Stephen should be able to find out about the Qualcomm cores,
and http://comments.gmane.org/gmane.linux.ports.arm.kernel/426289 has
some information about the others:
 * Brahma-B15 supports all three.
 * Dove (PJ4) reports idiv only in thumb mode, which I'm tempted to ignore
   for the kernel, as it supports neither lpae nor idiva.
 * Armada 370/XP (PJ4B) reports support for idiva and idivt, but according to
   https://groups.google.com/a/dartlang.org/forum/#!topic/reviews/9wvsJvq0YYY
   that may be a lie.
 * According to the same source, Krait fails to report idiva and idivt,
   but supports both anyway. However, I found reports on the web where
   /proc/cpuinfo correctly contains the flags on the same SoC (APQ8064)
   that was mentioned there, so maybe they were just running an old
   kernel.

	Arnd
