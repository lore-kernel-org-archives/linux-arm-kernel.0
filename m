From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 9 May 2012 13:36:07 +0300
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <4FA9BD41.2090701@codeaurora.org>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
Message-ID: <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 02:41:37AM +0200, Saravana Kannan wrote:
> On 05/08/2012 10:15 AM, Turquette, Mike wrote:
> > On Mon, May 7, 2012 at 10:07 PM, zhoujie wu<zhoujiewu@gmail.com>  wrote:
> >> Hi Mike,
> >> Could you please explain more details about how to implement a
> >> re-parenting operation as part of it's .set_rate implementation?
> >
> > Sure.
> >
> >> As far as I know, we can not call clk_set_parent in .set_rate function
> >> directly, since clk_set_rate and clk_set_parent are using the same
> >> prepare_lock.
> >
> > That is correct.
> >
> >> Any other interface can be used to implement it?
> >
> > You have two options available to you.
> >
> > 1) __clk_reparent can be used from your .set_rate callback today to
> > reflect changes made to the tree topology.  OMAP uses this in our PLL
> > .set_rate implementation: depending on the re-lock frequency the PLL
> > may switch parents dynamically.  __clk_reparent does the
> > framework-level cleanup needed for this (that function is also used
> > when populating the clock tree with new clock nodes).
> >
> > 2) __clk_set_parent could be made non-static if you needed this (I've
> > been meaning to talk to Saravana about this since I think MSM needs
> > something like this).
> 
> Thanks!
> 
> I don't think I need (2). But I don't think I can use (1) as is either. 
> I can use (1) with some additional code in my set rate op.
> 
> While set rate is in progress, both the parents might need to stay 
> enabled for a short duration. So, in my internal set rate, I need to 
> check if my clock is prepared/enabled and call prepare/enable on the 
> "old parent", call __clk_reparent (which will reduce the ref count for 
> the old parents and increase it for the new parents), finish the 
> reparent in HW and then unprepare/disable the old parent if I have 
> prepared/enabled them earlier.
> 
> It might be beneficial to provide something like a 
> __clk_reparent_start(new_parent, *scratch_pointer) and 
> __clk_reparent_finish(*scratch_pointer) if it will be useful for more 
> than just MSM. Based on this email, I would guess that Tegra would want 
> something similar too.
> 

We also need to reparent clocks using a pll if we want to change the PLLs rate
while the users are active.

Cheers,

Peter.
