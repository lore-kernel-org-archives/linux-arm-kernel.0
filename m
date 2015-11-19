From: lho@apm.com (Loc Ho)
Date: Thu, 19 Nov 2015 10:19:31 -0800
Subject: [PATCH RFC v2] apei: Add ACPI APEI event notification support
In-Reply-To: <20151119155158.GE6065@pd.tnic>
References: <1445458480-6493-1-git-send-email-lho@apm.com>
 <20151022095716.GC3671@pd.tnic> <20151119141816.GH22786@arm.com>
 <F77E0D1A-FE01-4BA8-B72C-AA6CB7DAD61C@redhat.com>
 <20151119155158.GE6065@pd.tnic>
Message-ID: <CAPw-ZTnAc+3ONLRBrY3wgj1vKofkM3+KuAixM2C9HhKz4jOY9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> Top post - quick reply - you are correct. This is a vendor specific
>> implementation. APEI is generic, and in the general case there should
>> not be a need to do anything with a special driver. Some will need
>> their own special solution in the early days, but everyone else should
>> be able to go generic. In particular I expect those implementing EL3
>> to do firmware first handling and to signal the event independently of
>> any OS specific hooks.
>
> In the meantime, I got these two patches:
>
> https://lkml.kernel.org/r/1446857519-5908-1-git-send-email-lho at apm.com
>
> which makes the GHES IRQ shared and, apparently solves the issue for
> APM.
>
> I'd appreciate it if you guys took a look.
>

Let me explain a bit so that all of you understand what was changed
between version 2 and 3. For background, the issue is how to clear the
interrupt. In version 2, this is via the Linux kernel driver. In
version 3, we moved this to the FW and have the FW configures the GIC
directly to just mark the error interrupts (as spec in the GHES table)
pending. As it is pending only, it will get clear after the interrupt
gets processed. In doing this, two issues was observed. One is the
fact that we have multiple error cascades into a few interrupts. The
second issue is how ACPI upper layer handles return codes an function.
The patch in version 3 addresses both of these issues.

-Loc
