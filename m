From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Dec 2012 23:07:52 +0900
Subject: [PATCH 01/12] regulator: gpio-regulator: Demote GPIO Regulator
 driver to start later
In-Reply-To: <1355129761-8088-2-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20121210140751.GB6103@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:55:50AM +0000, Lee Jones wrote:

> The normal course of action would be to defer the MMCI driver too,
> but these IOS level-shifter regulators aren't present on all
> platforms, so deferring until one is found would be incorrect.

> So the best solution is to demote the GPIO Regulator driver, so
> it starts later than the TC35892 GPIO controller, which is also
> configured to start at subsys_initcall() time, but before deferred
> probing time, which starts at late_initcall(), after many of the
> drivers requiring these regulators would have already started.

This really isn't a good solution, especially not for a system that's DT
based - on a DT system we can tell if there should be a GPIO present so
we should be able to defer only when there's something that might
provide the GPIO later on.
