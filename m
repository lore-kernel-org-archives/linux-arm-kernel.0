From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 3 Aug 2016 10:00:48 +0100
Subject: Can cores have different CPU features in a SMP system?
In-Reply-To: <CAP5Nno6Taupawth4pghFt4aidQx=ib=3yswdV=QPZeY6c-6RmQ@mail.gmail.com>
References: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
 <CAP5Nno4CN18x_L-UQPm0Wp7hFSQAKtRobV94iBkcB9y4-UeRpg@mail.gmail.com>
 <b9577b33-0401-cf0f-bac2-f0315f520356@arm.com>
 <CAP5Nno6Taupawth4pghFt4aidQx=ib=3yswdV=QPZeY6c-6RmQ@mail.gmail.com>
Message-ID: <c3706488-98db-9a71-22b1-0d56cfb3f2a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/16 18:23, Jun Sun wrote:
> Hi, Suzuki,
>
> I was looking at kernel 3.18 and drew the earlier conclusion.
>
> I'm now looking at kernel v4.7-rc4.  It appears the logic is
>
>   - cpu 0 sets up elf_hwcap (init_cpu_ftr_reg(), init_cpu_features() )

On arm64 CPU 0 doesn't set up elf_hwcap. It initialises the CPU feature register
infrastructure which keeps track of the system wide safe values for the ID
registers. init_cpu_features() initialises the table with the values from
the boot CPU. This will also be used to detect if any secondary CPU has
variations in features which could affect the normal functioning of Linux (via
update_cpu_features() -> check_update_ftr_reg() ).

The elf_hwcap and the system CPU_HWCAP bits are initialised only after all
the boot time active CPUs are online, from
setup_cpu_features()-> { setup_elf_hwcaps(), setup_feature_capabilities() }


>   - other cpus call verify_local_cpu_capabilities() in

All secondary CPUs call verify_local_cpu_capabilities(). But only the CPUs
which are brought up later by the user, perform capability, hwcap verification
and parks them if they miss something.


> secondary_start_kernel() and parks itself if it finds any missing
> features.
>
> Is this what you see? It seems to be slightly different from your description.

See above

>
> BTW, this is exactly the kind of enforcement I was hoping to see.  I
> couldn't be happier now. :) Thanks for your pointer.
>

Suzuki
