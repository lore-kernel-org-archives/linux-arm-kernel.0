From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Mar 2014 10:51:52 +0000
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <CAJ5Y-eYwMKXWiuAx_Kbv8XJ2Ym_jbStuNaNjtWe1RP8Xz+j-Rg@mail.gmail.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <20140320145742.GF23372@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eYwMKXWiuAx_Kbv8XJ2Ym_jbStuNaNjtWe1RP8Xz+j-Rg@mail.gmail.com>
Message-ID: <20140321105152.GL23372@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 03:39:30PM +0000, Ashwin Chaugule wrote:
> Hi Mark,
> 
> On 20 March 2014 10:57, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> >>
> >> +/* PSCI Function ID's for ARM32 as per PSCI spec v0.2 */
> >
> > Please drop the superfluous apostrophes, we aren't greengrocers [1].
> >
> > %s/ID's/IDs/
> 
> Ok. Will fix all the uncouth bacilli. ;)

Cheers :)

> >> +     psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
> >> +     psci_ops.cpu_suspend = psci_cpu_suspend;
> >> +
> >> +     psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
> >> +     psci_ops.cpu_off = psci_cpu_off;
> >> +
> >> +     psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
> >> +     psci_ops.cpu_on = psci_cpu_on;
> >> +
> >> +     psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
> >> +     psci_ops.migrate = psci_migrate;
> >> +
> >> +out_put_node:
> >> +     of_node_put(np);
> >> +     return err;
> >> +}
> >
> > I'd very much like to see us use AFFINITY_INFO from the start, or we've
> > got a racy down path (as we have for all PSCI implementations prior to
> > 0.2), and implementors are likely to skip implementing it if Linux seems
> > to work, so we'll never be able to rely on it.
> >
> > Additionally it'd be nice to check what MIGRATE_INFO_TYPE returns. If it
> > returns a value other than 2 (MP or not present), then there's some
> > additional work that we need to perform around a down path or we might
> > not be able to shut down some CPUs.
> 
> The main intention of this patch is to separate function ID detection
> depending on PSCI versions.
> So, I think the additional functionality of AFFINITY_INFO and
> MIGRATE_INFO_TYPE should go in as separate patches. Do you agree?

Unfortunately this has the side effect of seemingly adding support for
PSCI 0.2 while not actually doing so. I fear that people will begin
using the "arm,psci-0.2" string before we end up implementing code using
the other required functionality, and it will turn out we can't make use
of any of it, because it will cause someone's firmware to blow up.

I do not feel comfortable adding support for a not-quite-psci-0.2,
especially when adding trivial use of some required functionality does
not seem that difficult.

Cheers,
Mark.
