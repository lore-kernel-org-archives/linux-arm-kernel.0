From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 20:25:27 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <CAFEAcA-r_zi0-Q9=sT0YTQJ-HGYzLmoWNqtqN6ZV=01qOeCCMw@mail.gmail.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <12750898.0A5czJmNqv@wuerfel>
 <CAFEAcA-r_zi0-Q9=sT0YTQJ-HGYzLmoWNqtqN6ZV=01qOeCCMw@mail.gmail.com>
Message-ID: <6840047.0HF9qAEq6r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 13:29:29 Peter Maydell wrote:
> On 21 November 2015 at 23:21, Arnd Bergmann <arnd@arndb.de> wrote:
> > Regarding PJ4, it's still unclear whether that has the same
> > problem and it only reports idivt when it actually supports idiva,
> > or whether the lack of idiva support on PJ4 is instead the reason
> > why the ARM ARM was updated to have separate flags.
> 
> SDIV/IDIV were originally introduced for R and M profile only
> and there the Thumb encodings of SDIV/IDIV are mandatory
> whereas the ARM ones are optional (and weren't initially
> defined at all). So if you're looking for CPUs with only the
> Thumb encodings I would try checking older R profile cores
> like the Cortex-R4.

The question is really about Marvell Dove, MMP and Armada 370,
which are all based on PJ4 or PJ4B (CPU part : 0x581), so ARMv7-A
and report idivt support but idiva.

There are a couple of explanations here:

a) Marvell really implemented only idivt but not idiva
   and reports it correctly, and the people from
   https://groups.google.com/a/dartlang.org/forum/#!topic/reviews/9wvsJvq0YYY
   just misinterpreted the flags

b) the dartlag.org folks are correct, and it supports neither
   idivt nor idiva, and the /proc/cpuinfo flag is just wrong
   and requires a fixup

c) like Krait, it actually implements both idiva and idivt but
   gets the reporting wrong.

	Arnd
