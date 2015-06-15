From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jun 2015 09:58:05 -0600
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per
 pin muxing controllers
In-Reply-To: <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <557EF60D.8020007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
> When having a controller which allows per pin muxing, declaring with
> which groups a function can be used is a useless constraint since groups
> are something virtual.

This isn't true.

Irrespective of whether a particular piece of pinmux HW can control the 
mux function for each pin individually, or only in groups, it's quite 
likely that each function can only be selected onto a subset of those 
pins or groups. Requiring the pinctrl driver to inform the core which 
set of pins/groups particular functions can be selected onto seems quite 
reasonable.

In my opinion at least, for HW that can select the mux function at the 
per-pin level, the only sensible set of groups is one group per pin with 
each group containing a single pin. Any other use of groups is a 
SW/user-level construct, and is something unrelated to why the pinctrl 
subsystem supports groups. If we want to represent those groups in 
pinctrl, there should be two separate sets of groups; one to represent 
the actual HW capabilities, and one to represent the SW/user-level 
convenience abstractions.
