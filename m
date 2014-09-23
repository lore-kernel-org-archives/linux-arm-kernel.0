From: msalter@redhat.com (Mark Salter)
Date: Tue, 23 Sep 2014 17:25:13 -0400
Subject: [PATCH v3] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1411507260.25340.66.camel@deneb.redhat.com>
References: <1411167781-18571-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140922100912.GG30085@e104818-lin.cambridge.arm.com>
 <20140922170231.GM30085@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8=iSd+o09KAfHxWeXEkXGUZR1BeCuAvjAEem--s6U3zA@mail.gmail.com>
 <CAKv+Gu_F9QSJ-ruZndi=0+wQvXNS8F-LnBXOrNNVps+Rkb6n2g@mail.gmail.com>
 <1411507260.25340.66.camel@deneb.redhat.com>
Message-ID: <1411507513.25340.67.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-23 at 17:21 -0400, Mark Salter wrote:
> On Tue, 2014-09-23 at 10:23 +0200, Ard Biesheuvel wrote:
> > On 22 September 2014 21:44, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > On 22 September 2014 19:02, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >> On Mon, Sep 22, 2014 at 11:09:12AM +0100, Catalin Marinas wrote:
> > >>> On Sat, Sep 20, 2014 at 12:03:01AM +0100, Ard Biesheuvel wrote:
> > >>> > From: Yi Li <yi.li@linaro.org>
> > >>> >
> > >>> > SMBIOS is important for server hardware vendors. It implements a spec for
> > >>> > providing descriptive information about the platform. Things like serial
> > >>> > numbers, physical layout of the ports, build configuration data, and the like.
> > >>> >
> > >>> > This has been tested by dmidecode and lshw tools.
> > >>> >
> > >>> > This patch adds the call to dmi_scan_machine() to arm64_enter_virtual_mode(),
> > >>> > as that is the point where the EFI Configuration Tables are registered as
> > >>> > being available. It needs to be in an early_initcall anyway as dmi_id_init(),
> > >>> > which is an arch_initcall itself, depends on dmi_scan_machine() having been
> > >>> > called already.
> > >>> >
> > >>> > Signed-off-by: Yi Li <yi.li@linaro.org>
> > >>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>>
> > >>> Merged (until the next revert ;)). Thanks.
> > >>
> > >> And I'm about to revert it now. If Linux doesn't boot as an EFI
> > >> application, with this patch applied I get lots of:
> > >>
> > >
> > > And I guess each warning is for a different driver?
> > > That is another x86-ism we hadn't spotted that we need to get rid of:
> > > DMI is used for quirks handling on x86, and apparently it gets nervous
> > > if CONFIG_DMI is enabled but DMI never gets initialized. Can I assume
> > > that quirks handling based on the DMI system name is something you
> > > would prefer to steer clear of on arm64?
> > >
> > > This is non-trivial to fix in any case, so reverting it is the only
> > > option. If nobody else picks this up in the mean time, I will revisit
> > > this after my vacation (in the hope your patience hasn't run out yet)
> > >
> > 
> > As it turns out, this particular issue is caused by how I moved the
> > call to dmi_scan_machine() into arm64_enter_virtual_mode(), so it is
> > not present in Yi's original patch. When CONFIG_DMI is enabled,
> > dmi_scan_machine() needs to be called unconditionally, even if we are
> > running without EFI config tables (or any EFI for that matter)
> > 
> > @Yi: could you rework the patch so dmi_scan_machine() is called from a
> > separate function again? But this time, please add it to
> > arch/arm64/kernel/efi.c and invoke it using core_initcall not
> > arch_initcall. core_initcalls are dispatched before arch_initcall but
> > after early_initcall so that should be the right moment to get DMI
> > initialized.
> > 
> > Could you also test it with and without EFI?
> 
> efi.c is only compiled when CONFIG_EFI is defined, so you'd have to
> put it somewhere else.
> 
> Does dmi make any sense for arm64 in the absence of EFI? Why not make
> CONFIG_DMI depend on EFI. You still want to use a core_initcall in case
> runtime is disabled, but you could put it in efi.c in that case.
> 

Hmm, well maybe I should have read the patch more closely. It already
depends on EFI...
