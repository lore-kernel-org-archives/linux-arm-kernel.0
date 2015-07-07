From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Jul 2015 10:13:08 +0200
Subject: [PATCH 12/13] KVM: arm64: implement MSI injection in ITS emulation
In-Reply-To: <559AB0ED.1090405@arm.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-13-git-send-email-andre.przywara@arm.com>
 <5579C8AA.8010903@linaro.org> <559AB0ED.1090405@arm.com>
Message-ID: <20150707081308.GB13530@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 05:46:37PM +0100, Andre Przywara wrote:

[...]

> 
> >> +	inject = itte->enabled;
> >> +
> >> +out_unlock:
> >> +	spin_unlock(&its->lock);
> >> +
> >> +	if (inject) {
> >> +		spin_lock(&dist->lock);
> >> +		set_bit(cpuid, dist->irq_pending_on_cpu);
> > isn't it atomic op?
> 
> It is, but that's not what the lock protects. It's there to avoid
> stepping on someone else's toes, who might deal with the ITS data
> structures at the same time and would not expect a value to change in
> the middle (think about code iterating over dist->irq_pending_on_cpu).
> 
then should it be __set_bit ?

-Christoffer
