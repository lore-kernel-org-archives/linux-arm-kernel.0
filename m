From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 May 2013 09:47:44 +0100
Subject: [PATCH 14/14] ARM: elf: add new hwcap for identifying atomic
 ldrd/strd instructions
In-Reply-To: <CAL_JsqLSC2QgMdTGtH5G_F5SYjA3Hs--jMmxBES=fqGLwapptQ@mail.gmail.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
 <1368810473-26070-15-git-send-email-will.deacon@arm.com>
 <20130520141809.GA27473@arm.com>
 <CAL_JsqLSC2QgMdTGtH5G_F5SYjA3Hs--jMmxBES=fqGLwapptQ@mail.gmail.com>
Message-ID: <20130522084744.GD14322@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 07:48:35PM +0100, Rob Herring wrote:
> On Mon, May 20, 2013 at 9:18 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, May 17, 2013 at 06:07:53PM +0100, Will Deacon wrote:
> >> CPUs implementing LPAE have atomic ldrd/strd instructions, meaning that
> >> userspace software can avoid having to use the exclusive variants of
> >> these instructions if they wish.
> >>
> >> This patch advertises the atomicity of these instructions via the
> >> hwcaps, so userspace can detect this CPU feature.
> >>
> >> Reported-by: Vladimir Danushevsky <vladimir.danushevsky@oracle.com>
> >> Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ...
> >> +
> >> +     /* LPAE implies atomic ldrd/strd instructions */
> >> +     vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> >> +     if (vmsa >= 5)
> >> +             elf_hwcap |= HWCAP_LPAE;
> >
> > As I mentioned in the past, I don't agree with exposing the "LPAE"
> > feature to user-space, it's not a feature that user space should care
> > about. An atomic double hwcap is better and you can even make this per
> > CPU via __v7_proc.
> 
> How does userspace know whether to install a non-LPAE or LPAE kernel
> in a generic way?

This is a valid reason to expose LPAE to user, though elf_hwcap sounds a
bit strange.

-- 
Catalin
