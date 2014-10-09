From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 09 Oct 2014 19:28:38 +0200
Subject: [PATCH RFT 0/8] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <5436BE7F.7000603@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20141009163315.2a9e1806@free-electrons.com> <54369EAC.5040301@gmail.com>
 <20141009164704.7286fc3f@free-electrons.com> <5436A8B2.1030200@gmail.com>
 <5436BE7F.7000603@gmail.com>
Message-ID: <5436C5C6.3020406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2014 06:57 PM, Florian Fainelli wrote:
> On 10/09/2014 08:24 AM, Sebastian Hesselbarth wrote:
>> Yeah, but that HW PHY stuff really only works properly with standard
>> compliant PHYs. In particular, the integrated Marvell PHY in Marvell
>> Berlin SoCs does not seem to reflect PHY status on BMCR properly /sigh/.
>> Anyway, I think we can live with PHY polling.
>>
>> BTW, one thing I noticed here is that libphy calls adjust_link
>> over-and-over again although nothing has changed. I guess we can just
>> add some before/after comparison in the libphy state machine and only
>> call adjust_link when something has changed. I'll have to look closer
>> at the state machine first and maybe Florian can comment on this,
>> too.
>
> There's basically nothing built in the generic libphy that would try to
> limit the number of times the adjust_link() callback is invoked, some
> changes went in the bcmgenet driver to avoid that, I have yet to see how
> much of this logic is transferable to the libphy layer.

Ok, thanks for the clarification. I guess for the final patch series,
I'll add a check for both registers modified in foo_adjust_link to bail
out if there is no change. That will save the two register writes per
second or so and also allow to phy_print_status() after the writels.

Sebastian
