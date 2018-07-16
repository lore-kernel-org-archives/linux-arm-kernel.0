From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 16 Jul 2018 08:46:26 +0000
Subject: [PATCH] ARM: STi: at least warn if of_iomap fails
In-Reply-To: <50a1ccc1-e64a-a35e-a7b5-eeb7082478e9@st.com>
References: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
 <50a1ccc1-e64a-a35e-a7b5-eeb7082478e9@st.com>
Message-ID: <20180716084626.GA28893@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 07:55:08AM +0000, Patrice CHOTARD wrote:
> Hi Nicholas
> 
> On 07/12/2018 05:48 PM, Nicholas Mc Guire wrote:
> > The call to of_iomap() is unchecked but scu_enable(), which the returned
> > address is passed on to, assumes a valid mapping. If the mapping is
> > invalid this could probably lead to undefined system state so at least
> > a warning should be issued.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
> > ---
> > Problem was found by an experimental coccinelle script
> > 
> > Patch was compile tested with: multi_v7_defconfig (implies
> > CONFIG_ARCH_STI=y, CONFIG_SMP=y)
> > 
> > Patch is against 4.18-rc3 (localversion-next is next-20180712)
> > 
> >   arch/arm/mach-sti/platsmp.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> > index 231f19e..89ae76f 100644
> > --- a/arch/arm/mach-sti/platsmp.c
> > +++ b/arch/arm/mach-sti/platsmp.c
> > @@ -109,6 +109,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
> >   
> >   	if (np) {
> >   		scu_base = of_iomap(np, 0);
> > +		WARN_ON(!scu_base);
> >   		scu_enable(scu_base);
> >   		of_node_put(np);
> >   	}
> > 
> 
> I should prefer to exit with an error to avoid unpredictable behavior,
> something like this is better :
> 
> scu_base = of_iomap(np, 0);
> of_node_put(np);
> if (!scu_base) {
> 	pr_err("No SCU remap\n");
> 	return;
> }
> 
> scu_enable(scu_base);
>
even though it would be possible to locate that then from that message
would it not be prefereable to provide the infos upfront like:

	pr_err("SCU remap failed at %s:%s():%d\n",
               __FILE__, __func__, __LINE__);

if that makes sense I?ll resend - or is that considered too verbouse ?

thx!
hofrat
 
