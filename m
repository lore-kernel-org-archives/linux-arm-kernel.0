From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 13:21:24 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140925112122.GA22753@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just noticed these patches because they conflicted with some of the
local patches I had to add a very similar framework. One of the reasons
why I hadn't posted these publicly yet is because the platform where I
want to use this (Tegra) is somewhat quirky when it comes to power
domains.

On Tegra these domains are called power gates and they currently have
their own API. We've been looking at migrating things over to some
generic framework for some time and PM domains do seem like a good fit.
However one of the quirks regarding these domains on Tegra is that a
fixed sequence exists that needs to be respected when enabling or
disabling a power partition. The exact sequence can be found in the
drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
function. Essentially we need to call into the clock and reset drivers
at very specific moments during the operations that the PMC does.

One solution to this would be to make the needed clocks and resets
available to the power domain driver via DT, but then we have the
problem that two drivers would be controlling the same resources. For
example drivers could still want to disable the clock for more fine-
grained power management. Furthermore for some devices it may turn out
that turning the domain off and on introduces too much latency to be
useful.

Does anyone have any better ideas on how to make that work with this
generic PM domain framework? Or is Tegra just too special to be a good
fit?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/8242bb12/attachment.sig>
