From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 24 Feb 2018 20:16:44 +0000
Subject: [PATCH v4 10/40] KVM: arm64: Slightly improve debug save/restore
 functions
In-Reply-To: <20180224183236.GF7396@cbox>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-11-christoffer.dall@linaro.org>
 <20180221173903.xlpwnlrnjlpatm5s@kamzik.brq.redhat.com>
 <37712e4f-7f47-2101-71f5-d024a7993f13@arm.com>
 <20180224183236.GF7396@cbox>
Message-ID: <86zi3ynnwz.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Feb 2018 18:32:36 +0000,
Christoffer Dall wrote:
> 
> On Wed, Feb 21, 2018 at 05:52:41PM +0000, Marc Zyngier wrote:
> > On 21/02/18 17:39, Andrew Jones wrote:
> > > On Thu, Feb 15, 2018 at 10:03:02PM +0100, Christoffer Dall wrote:
> > >> The debug save/restore functions can be improved by using the has_vhe()
> > >> static key instead of the instruction alternative.  Using the static key
> > >> uses the same paradigm as we're going to use elsewhere, it makes the
> > >> code more readable, and it generates slightly better code (no
> > >> stack setups and function calls unless necessary).
> > >>
> > >> We also use a static key on the restore path, because it will be
> > >> marginally faster than loading a value from memory.
> > >>
> > >> Finally, we don't have to conditionally clear the debug dirty flag if
> > >> it's set, we can just clear it.
> > >>
> > >> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> > >> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > >> ---
> > >>
> > >> Notes:
> > >>     Changes since v1:
> > >>      - Change dot to comma in comment
> > >>      - Rename __debug_restore_spe to __debug_restore_spe_nvhe
> > >>
> > >>  arch/arm64/kvm/hyp/debug-sr.c | 26 ++++++++++++--------------
> > >>  1 file changed, 12 insertions(+), 14 deletions(-)
> > >>
> > > 
> > > Maybe after this series is merged, if there are any hyp_alternate_select's
> > > left, we can replace all the remaining ones with has_vhe() and then just
> > > completely remove hyp_alternate_select.
> > 
> > Note that older compilers (such as GCC 4.8) will generate horrible code
> > with static keys, as they do not support "asm goto". Not that I want to
> > preserve the home brew hyp_alternate_select mechanism, but I just want
> > to make it plain that some distros will definitely suffer from the
> > transition.
> > 
> That's unfortunate.  I'd still like to use has_vhe() most places, but we
> could change the implementation of has_vhe() to use the hyp alternative
> until nobody cares about kernels compiled with GCC 4.8 ?

Honestly, if you're using something as outdated as GCC 4.8, you
deserve to have crap performance. You end up with mediocre code
generation, and the lack of "asm goto" is just icing on the cake.

Given the kernel reliance on static keys for most things, I'd be
perfectly happy to drop the hyp alternative. It was only there because
we couldn't use static keys at hyp at the time, and we've moved on
since the initial VHE patches.

I cast my vote in favour of has_vhe() in its current form, everywhere.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
