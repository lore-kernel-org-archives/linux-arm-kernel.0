From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 10:18:21 +0000
Subject: [PATCH v2] ARM: teach __asmeq that r11 == fp and r12 == ip
In-Reply-To: <CAKv+Gu-z6ZNcYgbxyVJpUtkwhY-dq2h_7-ivZa_Qzg8PW-77Gw@mail.gmail.com>
References: <1422524686-30462-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150129114849.GZ26493@n2100.arm.linux.org.uk>
 <CAKv+Gu-z6ZNcYgbxyVJpUtkwhY-dq2h_7-ivZa_Qzg8PW-77Gw@mail.gmail.com>
Message-ID: <20150130101821.GI26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 07:21:18AM +0000, Ard Biesheuvel wrote:
> On 29 January 2015 at 11:48, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 29, 2015 at 09:44:46AM +0000, Ard Biesheuvel wrote:
> >> The __asmeq macro is used inside inline asm statements to ensure that
> >> register asm variables that explicitly specify a register are mapped
> >> correctly onto those registers when used in inline asm input and output
> >> constraints. However, the string based matching fails to take into account
> >> that 'fp' is often referred to as 'r11' and 'ip' is often referred to as
> >> 'r12', (e.g., by clang), causing false negatives.
> >>
> >> Fix this by making __asmeq consider the ("fp","r11"), ("r11","fp"),
> >> ("ip","r12") and ("r12","ip") cases specifically.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > The method adopted is rather horrid in itself, but I guess there's no
> > other way to deal with this... so I'm okay with the patch.  (I won't
> > say I'm happy with it!)
> >
> 
> How about we retain the old version unless __clang__ is defined?

I don't see much point - that only adds to the complexity with a
#ifdef.  The register names are equivalent in any compiler.

It's better that we avoid #ifdefs so we get better build coverage.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
