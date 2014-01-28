From: tinamdar@apm.com (Tanmay Inamdar)
Date: Mon, 27 Jan 2014 18:02:20 -0800
Subject: [RFC PATCH V2 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <CAErSpo5zMd_k407tvzPS85Nub9p2KMQnHJLTqd3eyvjdgfVtLg@mail.gmail.com>
References: <1389742458-7693-1-git-send-email-tinamdar@apm.com>
 <CACoXjc=ZT9fEm_KdY4WFSoS8n5FmO+hn9LjsR4m8YZG2iBbt5A@mail.gmail.com>
 <CACoXjc=-JtpiM3m4DSA_DeOxYr3sihGGf4FSaJ2yC08rpm6ANQ@mail.gmail.com>
 <5086198.ZOWZ5xuyna@wuerfel>
 <CAErSpo5zMd_k407tvzPS85Nub9p2KMQnHJLTqd3eyvjdgfVtLg@mail.gmail.com>
Message-ID: <CACoXjcn46u4QSoCZsd+FVBc2=EsGs3af8JzSw7uLw2ZNauX-Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 4:55 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We're only seeing Arnd's side of the conversation on linux-pci.
> Tanmay, are your messages being rejected because they're too "fancy",
> per the definition here: http://vger.kernel.org/majordomo-info.html ?
>

Thanks for pointing out. I am not sure though what's being detected as
fancy. I checked that my emails are received as plaintext on
majordomo. They are also displayed fine on LKML.

In this email, I have tried to keep the format of to: and cc: same as
first email in the thread. Not sure if this fixes the problem.

Again.. sorry for spamming.

> On Sat, Jan 25, 2014 at 1:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 24 January 2014 13:28:22 Tanmay Inamdar wrote:
>>> On Thu, Jan 16, 2014 at 5:10 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>>> > On Wed, Jan 15, 2014 at 4:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> >> On Wednesday 15 January 2014, Tanmay Inamdar wrote:
>>
>>> >>
>>> >>> +static void xgene_pcie_poll_linkup(struct xgene_pcie_port *port, u32 *lanes)
>>> >>> +{
>>> >>> +     void *csr_base = port->csr_base;
>>> >>> +     u32 val32;
>>> >>> +     u64 start_time, time;
>>> >>> +
>>> >>> +     /*
>>> >>> +      * A component enters the LTSSM Detect state within
>>> >>> +      * 20ms of the end of fundamental core reset.
>>> >>> +      */
>>> >>> +     msleep(XGENE_LTSSM_DETECT_WAIT);
>>> >>> +     port->link_up = 0;
>>> >>> +     start_time = jiffies;
>>> >>> +     do {
>>> >>> +             val32 = readl(csr_base + PCIECORE_CTLANDSTATUS);
>>> >>> +             if (val32 & LINK_UP_MASK) {
>>> >>> +                     port->link_up = 1;
>>> >>> +                     port->link_speed = PIPE_PHY_RATE_RD(val32);
>>> >>> +                     val32 = readl(csr_base + BRIDGE_STATUS_0);
>>> >>> +                     *lanes = val32 >> 26;
>>> >>> +             }
>>> >>> +             time = jiffies_to_msecs(jiffies - start_time);
>>> >>> +     } while ((!port->link_up) || (time <= XGENE_LTSSM_L0_WAIT));
>>> >>> +}
>>> >>
>>> >> Maybe another msleep() in the loop? It seems weird to first do an
>>> >> unconditional sleep but then busy-wait for the result.
>>> >
>>> > ok.
>>>
>>> This loop can execute for maximum 4 msec. So putting msleep(1) won't
>>> get us much.
>>
>> 4 msec is still quite a long time for a busy loop that can be spent doing
>> useful work in another thread.
>>
>>> >>
>>> >> Another general note: Your "compatible" strings are rather unspecific.
>>> >> Do you have a version number for this IP block? I suppose that it's related
>>> >> to one that has been used in other chips before, or will be used in future
>>> >> chips, if it's not actually licensed from some other company.
>>> >
>>> > I will have to check this.
>>> >
>>>
>>> We have decided to stick with current compatible string for now.
>>
>> Can you elaborate on your reasoning? Does this mean X-Gene is a one-off
>> product and you won't be doing any new chips based on the same hardware
>> components?
>>
>>         Arnd
