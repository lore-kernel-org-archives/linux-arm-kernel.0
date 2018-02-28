From: david@lechnology.com (David Lechner)
Date: Wed, 28 Feb 2018 15:40:40 -0600
Subject: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com>
 <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
Message-ID: <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 06:38 AM, Bartosz Golaszewski wrote:
> 
> I think I found the reason for the strange crashes we were
> experiencing (emac core->name being NULL) thanks to Sekhar who pointed
> me in the right direction.
> 
> The mdio driver fails to probe with v7 due to the supplied clock rate
> being wrong. Before failing we register the emac clock with
> pm_clk_add_clk(). When clock_ops puts the clock, it decreases the
> reference count of the clock, but we never actually increased it in
> the first place in the line above. The core clock code then destroys
> the associated clk_core structure. When the next user comes around (in
> our case the clk debug functions) the system crashes.
> 
> I believe there to be two issues: one is with v7 - we need to increase
> the clock reference count in davinci_psc_genpd_attach_dev().
> 
> Second is the error path in the clock framework - we should remove the
> destroyed clk_core from the debug list, which is not being done now.
> 
> Why we even need to track the refcount of clk_core is a mistery for me
> though. Stephen, Mike?
> 
> Best regards,
> Bartosz Golaszewski

Great find. I figured it had to be something like this, but I wasn't
able to reproduce the problem yet.

I suppose it is time to spin up a v8 with some fixes.
