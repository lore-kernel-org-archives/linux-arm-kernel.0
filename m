From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 10:20:51 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_JsqL8UnDco14Z8H7ZcxS=fLNiYgSb6ivv=zzpVctiD0FptA@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
 <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
 <20150429214924.GH5498@pd.tnic>
 <CAPw-ZTmoash48S3F8kBxsovD0mEPYBO8=XDaJ2peDu60yaGrZQ@mail.gmail.com>
 <20150429220830.GI5498@pd.tnic>
 <CAL_JsqL8UnDco14Z8H7ZcxS=fLNiYgSb6ivv=zzpVctiD0FptA@mail.gmail.com>
Message-ID: <20150430082051.GA3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 06:02:14PM -0500, Rob Herring wrote:
>  I think that it is silly to group otherwise independent things
> together and generally not what we do anywhere else in the kernel.
> They all likely have different capabilities and control mechanisms.

So let's look at the other extremity here: the moment someone releases
yet another "independent" IP block with some RAS functionality, same
someone will create yet another <vendor>_edac_<ip_block> driver. How
many independent IP blocks are there with RAS functionality? 10, 20,
100...? That number is most likely growing, I'd bet.

Oh, and then there'll probably be functionality which is needed by two
IP blocks so it needs to be shared. So we either copy'paste stuff or
create a lib only for that functionality...

Even worse, what if two EDAC drivers for two IP blocks would need to
talk to each other. That'll be fun.

Or there'll be a v2 of the IP block which has almost the same
functionality but no 100% - just a *little* different. So then we go
create <vendor>_edac_<ip_block-v2> driver. Yuck!

What I would prefer is to concentrate all vendor-specific RAS
functionality in one single driver. Shared functionality is then taken
care of automagically with all the synergies (I hate that word!)
involved and no unnecessary too finer-grained splitting.

In that case, we would only have to enable loading more than one EDAC
drivers on a system which has different RAS IP blocks. Now *that* is a
much cleaner solution IMO which will keep the sanity in EDAC-land above
0.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
