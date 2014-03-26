From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Mar 2014 01:00:14 +0100
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <53321311.8060604@ahsoftware.de>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>	<1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>	<20140316070917.GA3094@arch.cereza>	<CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>	<20140317204410.GA1118@arch.cereza>	<CADHgK6tHngKVZS=jo=VYt3Nt3dhiEmiWr28iDy7q_uR9goBj=Q@mail.gmail.com>	<20140319154434.GA3488@arch.cereza>	<CADHgK6vLB3h0zrdpve=ZyjNu2pe1VYsGxrYgv=2C-JV37vE9tQ@mail.gmail.com>
 <CADHgK6vkwjXyJxRcOXjJpJJaR0-YR869NpPZ+CBBS8kEdE0qCQ@mail.gmail.com>
 <5331CD43.1010601@ahsoftware.de> <53321311.8060604@ahsoftware.de>
Message-ID: <5332188E.7050302@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.03.2014 00:36, schrieb Alexander Holler:
> Am 25.03.2014 19:38, schrieb Alexander Holler:
>
>> reboot too. Another solution would be to unregister the reboot_notifier
>> in the reboot_nofifier itself. I've just seen one watchdog driver
>> (drivers/rtc/rtc-m41t80.c) which does that. But I still think such
>
> That, btw. is broken. ;)
>
> Right after having send the mail, I've became that intuition, had a look
> and ... notifier.h does state the following:
>
>   * atomic_notifier_chain_unregister(),
> blocking_notifier_chain_unregister(),
>   * and srcu_notifier_chain_unregister() _must not_ be called from within
>   * the call chain.
>
> (The reboot-notifier chain is of type blocking_notifier_chain)
>
> So I've picked up one user of reboot_notifier by random and had the luck
> to choose a broken one. ;)
>
> I will make a patch and will have a look if the same failure can be
> found elsewhere. There aren't that much users of the reboot-notifier, so
> it shouldn't cost me that much time.

Hmm, and either I was confused, or have looked at some other user of the 
reboot_notifier, but rtc-m41t80.c doesn't call unregister from it's 
notifier. And unfortunately there are a bit more users of the 
reboot_notifier than I first thought. :/

I will check if I can find out at least at which driver I had a look at 
which did call unregister_notifier from the notifier itself.

Regards,

Alexander Holler
