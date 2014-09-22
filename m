From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Sep 2014 21:44:19 +0200
Subject: [PATCH v3] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20140922170231.GM30085@e104818-lin.cambridge.arm.com>
References: <1411167781-18571-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140922100912.GG30085@e104818-lin.cambridge.arm.com>
 <20140922170231.GM30085@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8=iSd+o09KAfHxWeXEkXGUZR1BeCuAvjAEem--s6U3zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 September 2014 19:02, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Sep 22, 2014 at 11:09:12AM +0100, Catalin Marinas wrote:
>> On Sat, Sep 20, 2014 at 12:03:01AM +0100, Ard Biesheuvel wrote:
>> > From: Yi Li <yi.li@linaro.org>
>> >
>> > SMBIOS is important for server hardware vendors. It implements a spec for
>> > providing descriptive information about the platform. Things like serial
>> > numbers, physical layout of the ports, build configuration data, and the like.
>> >
>> > This has been tested by dmidecode and lshw tools.
>> >
>> > This patch adds the call to dmi_scan_machine() to arm64_enter_virtual_mode(),
>> > as that is the point where the EFI Configuration Tables are registered as
>> > being available. It needs to be in an early_initcall anyway as dmi_id_init(),
>> > which is an arch_initcall itself, depends on dmi_scan_machine() having been
>> > called already.
>> >
>> > Signed-off-by: Yi Li <yi.li@linaro.org>
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Merged (until the next revert ;)). Thanks.
>
> And I'm about to revert it now. If Linux doesn't boot as an EFI
> application, with this patch applied I get lots of:
>

And I guess each warning is for a different driver?
That is another x86-ism we hadn't spotted that we need to get rid of:
DMI is used for quirks handling on x86, and apparently it gets nervous
if CONFIG_DMI is enabled but DMI never gets initialized. Can I assume
that quirks handling based on the DMI system name is something you
would prefer to steer clear of on arm64?

This is non-trivial to fix in any case, so reverting it is the only
option. If nobody else picks this up in the mean time, I will revisit
this after my vacation (in the hope your patience hasn't run out yet)

-- 
Ard.


> WARNING: CPU: 4 PID: 1 at
> /work/Linux/linux-2.6-aarch64/drivers/firmware/dmi_scan.c:591
> dmi_matches+0x10c/0x110()
> dmi check: not initialized yet.
> Modules linked in:
> CPU: 4 PID: 1 Comm: swapper/0 Not tainted 3.17.0-rc4+ #606
> Call trace:
> [<ffffffc000087fb0>] dump_backtrace+0x0/0x124
> [<ffffffc0000880e4>] show_stack+0x10/0x1c
> [<ffffffc0004d58f8>] dump_stack+0x74/0xb8
> [<ffffffc0000ab640>] warn_slowpath_common+0x8c/0xb4
> [<ffffffc0000ab6b4>] warn_slowpath_fmt+0x4c/0x58
> [<ffffffc0003f2d7c>] dmi_matches+0x108/0x110
> [<ffffffc0003f2da8>] dmi_check_system+0x24/0x68
> [<ffffffc0006974c4>] atkbd_init+0x10/0x34
> [<ffffffc0000814ac>] do_one_initcall+0x88/0x1a0
> [<ffffffc00067aab4>] kernel_init_freeable+0x148/0x1e8
> [<ffffffc0004d2c64>] kernel_init+0x10/0xd4
>
> --
> Catalin
