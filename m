From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 18:04:31 +0100
Subject: [PATCH] [media] zl10353: use div_u64 instead of do_div
In-Reply-To: <20160212143220.5a440e66@recife.lan>
References: <1455287246-3540549-1-git-send-email-arnd@arndb.de>
 <20160212143220.5a440e66@recife.lan>
Message-ID: <2712691.b9gkR7KMX7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 14:32:20 Mauro Carvalho Chehab wrote:
> Em Fri, 12 Feb 2016 15:27:18 +0100
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
> > I noticed a build error in some randconfig builds in the zl10353 driver:
> > 
> > dvb-frontends/zl10353.c:138: undefined reference to `____ilog2_NaN'
> > dvb-frontends/zl10353.c:138: undefined reference to `__aeabi_uldivmod'
> > 
> > The problem can be tracked down to the use of -fprofile-arcs (using
> > CONFIG_GCOV_PROFILE_ALL) in combination with CONFIG_PROFILE_ALL_BRANCHES
> > on gcc version 4.9 or higher, when it fails to reliably optimize
> > constant expressions.
> > 
> > Using div_u64() instead of do_div() makes the code slightly more
> > readable by both humans and by gcc, which gives the compiler enough
> > of a break to figure it all out.
> 
> I'm not against this patch, but we have 94 occurrences of do_div() 
> just at the media subsystem. If this is failing here, it would likely
> fail with other drivers. So, I guess we should either fix do_div() or
> convert all such occurrences to do_div64().

I agree that it's possible that the same problem exists elsewhere, but this is
the only one that I ever saw (in five ranconfig builds out of 8035 last week).

I also tried changing do_div() to be an inline function with just a small
macro wrapper around it for the odd calling conventions, which also made this
error go away. I would assume that Nico had a good reason for doing do_div()
the way he did. In some other files, I saw the object code grow by a few
instructions, but the examples I looked at were otherwise identical.

I can imagine that there might be cases where the constant-argument optimization
of do_div fails when we go through an inline function in some combination
of Kconfig options and compiler version, though I don't think that was
the case here.

Nico, any other thoughts on this?

	Arnd
