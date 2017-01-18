From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Jan 2017 21:44:59 +0100
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
In-Reply-To: <20170116211540.GA19736@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170116211540.GA19736@amd>
Message-ID: <20170118204459.GA5622@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > So regression seems to be between v4.9 and v4.10. Any ideas?
> > 
> > Interesting... seems there are no sound relevant changes after v4.9.
> > 
> > Looks like there are only three commits after v4.9 for sound/soc which 
> > are built for Nokia N900:
...
> Its definitely caused by something merged here:
> 
> commit ce38207f161513ee3d2bd3860489f07ebe65bc78
> Merge: a9042de 995c6a7
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Dec 14 11:14:28 2016 -0800
> 
> So it should be easy to find out..

Doing git bisect now. Hmmm.

pavel at amd:/data/l/linux-n900$ git bisect bad
1a653aa44725668590b36bbe2d7fe4736a69f055 is the first bad commit
commit 1a653aa44725668590b36bbe2d7fe4736a69f055
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Wed Nov 30 06:22:55 2016 +0000

    ASoC: core: replace aux_comp_list to component_dev_list

    Now, Card has component_dev_list, we can replace aux_comp_list
        to component_dev_list with new auxiliary flags

    Signed-off-by: Kuninori Morimoto
    <kuninori.morimoto.gx@renesas.com>
        Signed-off-by: Mark Brown <broonie@kernel.org>

:040000 040000 a571fa05e5ce8e00b73bbc3f1e30e26775d619e8
e9336929cacf2d7bc94da99acfc10c9a7f513b8b M	include
:040000 040000 87976e9406d452e791870cc12e27cb67ba04fd12
60d36f685642621c0e3ebb61ba7a14186d8b3eb0 M	sound
pavel at amd:/data/l/linux-n900$

I'll try reverting this patch on top of 4.10-rc, next. Any other ideas?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/5c10026d/attachment.sig>
