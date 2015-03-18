From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 18 Mar 2015 02:16:43 +0100
Subject: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
In-Reply-To: <20150317142555.GW8656@n2100.arm.linux.org.uk>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <37566526.IvGLQo2usO@vostro.rjw.lan>
 <20150317142555.GW8656@n2100.arm.linux.org.uk>
Message-ID: <41985989.P7cCrZRiSl@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 17, 2015 02:25:55 PM Russell King - ARM Linux wrote:
> On Tue, Mar 17, 2015 at 03:45:55PM +0100, Rafael J. Wysocki wrote:
> > Well, I wouldn't really like to add new callbacks to struct bus_type for
> > intermediate steps, because that's guaranteed to lead to confusion.
> > 
> > So I think the infrastructure is better added first and users may be
> > switched over to it gradually.
> > 
> > I don't see any particular problems with moving the ACPI PM domain
> > attach/detach to bus_add/remove_device(), so that can be done as the first
> > step.  As for genpd, it can implement the ->post_probe thing first and do
> > the rest in the bus type ->probe until the generic code is ready.
> 
> At what point do you see the genpd binding taking place - remembering
> that this can fail with -EPROBE_DEFER when DT specifies a genpd, but
> the domain hasn't been registered yet?

That -EPROBE_DEFER needs to be returned from the ->pre_probe callback
I think.  Otherwise bus types would need to duplicate that code.

> I'm guessing that needs to happen either in the bus type ->probe or
> the ->pre_probe callback.  ->pre_probe sounds better as it can be
> a standard genpd function which bus types hook directly into that
> method.

Right.

Still, I'd like the bus type's (new) ->pm_domain_init (or whatever it will
be eventually) to be used for populating the devices' ->pm_domain pointers.
There are two reasons for that.  First, those pointers only need to be
populated once per device life cycle (and not during every driver probe/remove).
Second, that will make limited power management of devices without drivers
possible (at least in the ACPI case).

Rafael
