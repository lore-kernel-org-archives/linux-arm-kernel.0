From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 May 2012 07:22:34 -0700
Subject: [PATCH] net: davinci_emac: Add pre_open,
 post_stop platform callbacks
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA72820@DBDE01.ent.ti.com>
 (Vaibhav Bedia's message of "Thu, 3 May 2012 10:44:44 +0000")
References: <20120502234718.GA5432@animalcreek.com>
 <B5906170F1614E41A8A28DE3B8D121433EA72820@DBDE01.ent.ti.com>
Message-ID: <87sjfhmjit.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> On Thu, May 03, 2012 at 05:17:18, Mark A. Greer wrote:
>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>> 
>> The davinci EMAC driver has been incorporated into the am35x
>> family of SoC's which is OMAP-based.  The incorporation is
>> incomplete in that the EMAC cannot unblock the [ARM] core if
>> its blocked on a 'wfi' instruction.  This is an issue with
>> the cpu_idle code because it has the core execute a 'wfi'
>> instruction.
>> 
>> To work around this issue, add platform data callbacks which
>> are called at the beginning of the open routine and at the
>> end of the stop routine of the davinci_emac driver.  The
>> callbacks allow the platform code to issue disable_hlt() and
>> enable_hlt() calls appropriately.  Calling disable_hlt()
>> prevents cpu_idle from issuing the 'wfi' instruction.
>> 
>> It is not sufficient to simply call disable_hlt() when
>> there is an EMAC present because it could be present but
>> not actually used in which case, we do want the 'wfi' to
>> be executed.
>> 
>
> Are you trying to say that if ARM executes _just_ wfi and _absolutely
> nothing else_ is done in the OMAP PM code, EMAC stops working?
>
> However, if this is indeed the case, then probably a better solution would be
> to invoke disable_hlt() from the board file when EMAC support is compiled in.

No.  As Mark stated in the changelog, doing that will prevent any
low-power states states even if the EMAC is not in use.  IMO, it is best
to only prevent WFI when absolutely needed.

Kevin
