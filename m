From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jan 2014 10:46:38 +0100
Subject: [PATCH v2 02/15] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5118193.GjKusj569J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014 06:12:28 Ezequiel Garcia wrote:
> -/*
> - * Thread-safe access to TIMER_CTRL register
> - * (shared with watchdog timer)
> - */
> -void orion_timer_ctrl_clrset(u32 clr, u32 set)
> -{
> -       spin_lock(&timer_ctrl_lock);
> -       writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
> -               timer_base + TIMER_CTRL);
> -       spin_unlock(&timer_ctrl_lock);
> -}
> -EXPORT_SYMBOL(orion_timer_ctrl_clrset);

I don't understand what's wrong with this function, it seems like
a cleaner approach than touching the register directly from two
different drivers. Is this something that would only work on
orion but not on armadaxp?


	Arnd
