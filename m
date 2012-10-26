From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 25 Oct 2012 17:34:02 -0700
Subject: [PATCH v2 5/7] crypto: omap-sham: Convert to use pm_runtime API
In-Reply-To: <1351046167-4882-6-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Tue, 23 Oct 2012 19:36:05 -0700")
References: <1351046167-4882-1-git-send-email-mgreer@animalcreek.com>
 <1351046167-4882-6-git-send-email-mgreer@animalcreek.com>
Message-ID: <87lieunkat.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Convert the omap-sham crypto driver to use the
> pm_runtime API instead of the clk API.
>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

I can't pretend to fully understand this driver, It looks like the
current code is doing a bit more fine-grained clock gating, and leaving
the IP clocked only when needed.

The proposed version does a 'get' in probe and a 'put' in remove, which
means the IP will always be enabled (and thus preventing low-power
states), even when it's not in use.

If that's really needed, it should be thoroughly described in the
changelog, otherwise I suggest doing the runtime PM 'get' and 'put' in
roughtly the same spots as the current clk enable/disable which makes
this a more straight-forward conversion.

Kevin
