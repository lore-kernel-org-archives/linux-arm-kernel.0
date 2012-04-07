From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 06 Apr 2012 18:44:34 -0700
Subject: [PATCH v5 09/16] pwm: tegra: Add device tree support
In-Reply-To: <4F7C93A4.5000906@wwwdotorg.org>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-10-git-send-email-thierry.reding@avionic-design.de>
 <4F7602CD.2010808@wwwdotorg.org>
 <20120402083749.GA6576@avionic-0098.adnet.avionic-design.de>
 <4F79C8D4.2000306@wwwdotorg.org>
 <20120403175511.GA26399@avionic-0098.mockup.avionic-design.de>
 <20120403234249.E292E3E03F3@localhost>
 <20120404050054.GA30807@avionic-0098.adnet.avionic-design.de>
 <4F7C93A4.5000906@wwwdotorg.org>
Message-ID: <20120407014434.D28983E23CD@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Apr 2012 12:32:04 -0600, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/03/2012 11:00 PM, Thierry Reding wrote:
> > * Grant Likely wrote:
> >> On Tue, 3 Apr 2012 19:55:11 +0200, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> >>> * Stephen Warren wrote:
> >>>> On 04/02/2012 02:37 AM, Thierry Reding wrote:
> >>>>> * Stephen Warren wrote:
> >>>>>> On 03/28/2012 08:33 AM, Thierry Reding wrote:
> >>>>>>> Add auxdata to instantiate the PWFM controller from a device tree,
> >>>>>>> include the corresponding nodes in the dtsi files for Tegra 20 and
> >>>>>>> Tegra 30 and add binding documentation.
> >>>>>>>
> >>>>>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >>>>>>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> >>>>>>
> >>>>>>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> >>>>>> ...
> >>>>>>> +#ifdef CONFIG_OF
> >>>>>>> +static struct of_device_id tegra_pwm_of_match[] = {
> >>>>>>> +	{ .compatible = "nvidia,tegra20-pwm" },
> >>>>>>> +	{ .compatible = "nvidia,tegra30-pwm" },
> >>>>>>
> >>>>>> Could you swap those two lines, so that tegra30-pwm matches first. It
> >>>>>> makes no difference at present, but might in the future if the driver
> >>>>>> actually has to differentiate the two SoCs.
> >>>>>
> >>>>> I thought the matching order was determined by the compatible property in the
> >>>>> device tree, not the OF match table of the driver.
> >>>>
> >>>> At least logically, yes. However, of_match_device() appears to iterate
> >>>> over each match table entry, checking whether it matches any string in
> >>>> the compatible flag. Perhaps this could be considered a bug?
> >>>
> >>> It certainly is counter-intuitive. Maybe Grant or Rob can comment?
> >>
> >> Yes, it is a bug.  The order of of_device_id should be entirely
> >> irrelevant, and the order in the DT compatible property should
> >> determine which match entry is returned.
> > 
> > I've had a look at the code and it looks like a fix will not be entirely
> > trivial. I think moving out the compatible check out of the while loop in
> > of_match_node() and separately iterate over all strings in the compatible
> > property would be the easiest. That will also prioritize the compatible
> > match over matches by name and type but I think that's exactly what we
> > want. From a quick look it certainly seems like the large majority of
> > drivers match by compatible anyway.
> > 
> > Do you want me to prepare a patch or can you take care of it?

yes please.

g.
