From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Feb 2015 10:37:51 +0000
Subject: [PATCH] compat: Fix endian issue in union sigval
In-Reply-To: <54ECF309.3020509@ezchip.com>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com>
 <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
 <54DB3B60.4050100@huawei.com>
 <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
 <54DDAF2B.2070707@huawei.com>
 <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
 <54DE730D.3090100@ezchip.com> <20150214112220.GB10246@MBP.local>
 <54ECF309.3020509@ezchip.com>
Message-ID: <20150225103750.GC22206@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 04:54:17PM -0500, Chris Metcalf wrote:
> On 2/14/2015 6:22 AM, Catalin Marinas wrote:
> >1. user populates sival_int compat_sigevent and invokes
> >    compat_sys_mq_notify()
> >2. kernel get_compat_sigevent() copies compat_sigevent into the native
> >    sigevent. compat and native sival_int are the same, no problem so
> >    far. The other half of 64-bit sival_ptr is zeroed by a memset in this
> >    function (this other half can be top or bottom, depending on
> >    endianness)
> >3. signal is about to be delivered to user via arch code. The
> >    compat_ptr(from->si_ptr) conversion always takes the least
> >    significant part of the native si_ptr. On big endian 64-bit, this is
> >    zero because get_compat_sigevent() populated the top part of si_ptr
> >    with si_int.
> >
> >So delivering such signals to compat user always sets si_int to 0.
> >Little endian is fine.
> 
> I looked at this again as I was getting ready to do a tile patch, and realized
> why tile and arm64 are different here: tile does a field-by-field copy in
> copy_siginfo_from_user32(), like parisc and s390.  As a result, we initialize
> the 64-bit kernel si_ptr value by cast from the 32-bit user si_ptr value, rather
> than blindly writing into the lower-addressed half of the 64-bit sigval.

It's not about copy_siginfo_from_user32() but the generic
get_compat_sigevent() which always uses sival_int (called from e.g.
compat_sys_timer_create()).

-- 
Catalin
