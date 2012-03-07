From: vapier@gentoo.org (Mike Frysinger)
Date: Wed, 7 Mar 2012 13:25:51 -0500
Subject: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <4F579DE0.3050400@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <201203062256.16105.vapier@gentoo.org> <4F579DE0.3050400@wwwdotorg.org>
Message-ID: <201203071326.00264.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:41:52 Stephen Warren wrote:
> On 03/06/2012 08:56 PM, Mike Frysinger wrote:
> > On Tuesday 06 March 2012 19:30:36 Stephen Warren wrote:
> >> +UIMAGE_ENTRYADDR = $(shell $(NM) vmlinux | awk '$$NF == "__start"
> >> {print $$1}')
> > 
> > i feel like if we tried harder, we could automate the -e arg for all
> > arches. i understand if you don't want to undertake that though.
> 
> Yes, this might be possible. I'd guess the symbol name varies between
> archs, but that can probably be taken care of.

i think we could avoid the symbol lookup.  if the entry point is set correctly 
in the ELF, we could do:
UIMAGE_ENTRYADDR = $(shell $(READELF) -h vmlinux | \
	awk '$$0 ~ /Entry point address:/ { print $$NF }'

99% sure this would work for Blackfin kernel images ...

> This is probably best
> left as a follow-on patch though, since it's a behavioral change,
> whereas this patch is just consolidation.

of course
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/0fe6ffb2/attachment.sig>
