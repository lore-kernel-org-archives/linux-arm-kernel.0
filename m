From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Mar 2015 14:25:55 +0000
Subject: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
In-Reply-To: <37566526.IvGLQo2usO@vostro.rjw.lan>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <5508804.qPsCdhOgnd@vostro.rjw.lan>
 <CAPDyKFoVcZAc4FKkG_ywk6qrqrGMp=0aT+LGigWPiXg-TTi0CA@mail.gmail.com>
 <37566526.IvGLQo2usO@vostro.rjw.lan>
Message-ID: <20150317142555.GW8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 03:45:55PM +0100, Rafael J. Wysocki wrote:
> Well, I wouldn't really like to add new callbacks to struct bus_type for
> intermediate steps, because that's guaranteed to lead to confusion.
> 
> So I think the infrastructure is better added first and users may be
> switched over to it gradually.
> 
> I don't see any particular problems with moving the ACPI PM domain
> attach/detach to bus_add/remove_device(), so that can be done as the first
> step.  As for genpd, it can implement the ->post_probe thing first and do
> the rest in the bus type ->probe until the generic code is ready.

At what point do you see the genpd binding taking place - remembering
that this can fail with -EPROBE_DEFER when DT specifies a genpd, but
the domain hasn't been registered yet?

I'm guessing that needs to happen either in the bus type ->probe or
the ->pre_probe callback.  ->pre_probe sounds better as it can be
a standard genpd function which bus types hook directly into that
method.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
