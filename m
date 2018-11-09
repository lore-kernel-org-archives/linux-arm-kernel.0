From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 9 Nov 2018 12:33:28 -0800
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
In-Reply-To: <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
Message-ID: <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/18 12:22 PM, Heiner Kallweit wrote:
> On 09.11.2018 21:13, Andrew Lunn wrote:
>> Hi Heiner
>>
>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>>> +{
>>> +	return phydrv->config_intr || phydrv->ack_interrupt;
>>> +}
>>
>> Should this be && not || ? I thought both needed to be provided for
>> interrupts to work. 
>>
>> 	   Andrew
>>
> I've seen at least one driver which configures interrupts in
> config_init and doesn't define a config_intr callback
> (ack_interrupt callback is there)

That driver should probably be fixed, while it most likely does not make
any significant difference during probe/connect, since config_init() and
config_intr() are virtually happening at the same time, this is not
necessarily true when disconnecting from the PHY where we really want
config_intr() to effectively disable the interrupts and not leaving
something enabled that would now become unmaskable, because no more
driver attached.

> Intention of this check is not to ensure that the driver defines
> everything to make interrupts work. All it states:
> If at least one of the irq-related callbacks is defined, then
> we interpret this as indicator that the PHY supports interrupts.

I agree with Andrew here, that this should be an AND here, both
callbacks must be implemented for interrupts to work correctly.
-- 
Florian
