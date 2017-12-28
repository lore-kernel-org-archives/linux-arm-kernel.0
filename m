From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Dec 2017 12:26:21 +0100
Subject: v4.15: camera problems on n900
In-Reply-To: <20171227211718.favif66afztygfje@kekkonen.localdomain>
References: <20171227210543.GA19719@amd>
 <20171227211718.favif66afztygfje@kekkonen.localdomain>
Message-ID: <20171228112621.GA854@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-12-27 23:17:19, Sakari Ailus wrote:
> On Wed, Dec 27, 2017 at 10:05:43PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
> > seconds, but then I get repeated oopses.
> > 
> > On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
> > camera does not start.	  
> > 
> > Any ideas what might be wrong there?
> 
> What kind of oopses do you get?

Haven't seen the oopses yet; maybe they are only on linux-next?
Anyway, bisect so far:

# bad: [fb3f95c11904adf26c2bd86fe1b1613c921710b5] Config for v4.15-rc0.5
# good: [c213cf57c2f15ee226c14dd7157caa334c3ef7c8] Make config similar to n950 case. Still works on n900.
git bisect start 'mini-v4.15' 'mini-v4.14'
# good: [06410bdec961a55e78e01d4fda199f709a84e17f] Merge /data/l/clean-cg into mini-v4.14
git bisect good 06410bdec961a55e78e01d4fda199f709a84e17f
# bad: [fc35c1966e1372a21a88f6655279361e2f92713f] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad fc35c1966e1372a21a88f6655279361e2f92713f
# good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
git bisect good bebc6082da0a9f5d47a1ea2edc099bf671058bd4
# good: [5bbcc0f595fadb4cac0eddc4401035ec0bd95b09] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 5bbcc0f595fadb4cac0eddc4401035ec0bd95b09
# bad: [5b0e2cb020085efe202123162502e0b551e49a0e] Merge tag 'powerpc-4.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad 5b0e2cb020085efe202123162502e0b551e49a0e
# good: [f150891fd9878ef0d9197c4e8451ce67c3bdd014] Merge tag 'exynos-drm-next-for-v4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-next
git bisect good f150891fd9878ef0d9197c4e8451ce67c3bdd014
# good: [93ea0eb7d77afab34657715630d692a78b8cea6a] Merge tag 'leaks-4.15-rc1' of git://github.com/tcharding/linux
git bisect good 93ea0eb7d77afab34657715630d692a78b8cea6a
# bad: [2bf16b7a73caf3435f782e4170cfe563675e10f9] Merge tag 'char-misc-4.15-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad 2bf16b7a73caf3435f782e4170cfe563675e10f9
# good: [ef674997e49760137ca9a90aac41a9922ac399b2] media: staging: atomisp: Convert timers to use timer_setup()
git bisect good ef674997e49760137ca9a90aac41a9922ac399b2
# good: [b1cb7372fa822af6c06c8045963571d13ad6348b] dvb_frontend: don't use-after-free the frontend struct
git bisect good b1cb7372fa822af6c06c8045963571d13ad6348b


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/413292c1/attachment.sig>
