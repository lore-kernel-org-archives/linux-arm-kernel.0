From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 29 Mar 2017 12:28:59 -0700
Subject: [PATCH v4 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <CABb+yY31oW09-fq_t4V6vatMe50Ed2Mi00kT4bOJv2=qFBT+QA@mail.gmail.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
 <CABb+yY0rmAFutskhVkQ926QfsvtJ-WnXrQc=+PQNg=7NZEXC+Q@mail.gmail.com>
 <09177a6f-0612-1e17-a12e-0b1969f5b2e1@broadcom.com>
 <CABb+yY1o7QTYLm3HGWNeFDPnfpL7AAJ6+R91Stn-gNvO7afxoA@mail.gmail.com>
 <22d07bb1-9e93-4ae5-7215-923bde9ebfe5@broadcom.com>
 <CABb+yY1kbFOKJPO95SRw995zt=fCoA+SkXgECOj774i_hJUCNg@mail.gmail.com>
 <0e8ac72a-6b2f-171d-41e7-7a6cefc4c7c4@broadcom.com>
 <CABb+yY31oW09-fq_t4V6vatMe50Ed2Mi00kT4bOJv2=qFBT+QA@mail.gmail.com>
Message-ID: <414f9d26-c62f-d1dd-69b4-717d42be38ba@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17-03-28 09:36 PM, Jassi Brar wrote:
> On Tue, Mar 28, 2017 at 11:00 PM, Jonathan Richardson
> <jonathan.richardson@broadcom.com> wrote:
>> On 17-03-15 10:30 AM, Jassi Brar wrote:
>>> The right way to do is have a 'server/owner' client that accepts
>>> requests from various clients and serially queue them to mailbox. That
>>> way you can keep the controller driver free from quirks (like max wait
>>> time of 30us) of your present platform.
>> Do you mean 1 mailbox client with one mailbox channel that all the mbox client drivers share?
>> I thought this would work when I suggested it previously but the client callbacks are necessary
>> in all txdone modes. Client drivers that send the messages need the callbacks
>>
> That's a legit requirement.
>
>> and this is only possible with multiple mbox clients.
>>
> That is incorrect.
> It is trivial to support callbacks to end clients from your common
> code... just ask for callback along with the message to be submitted
> to mailbox api.

Ok, if we can provide our own callbacks in the message instead of the client then that's perfectly fine.

>
>> And a channel can only have 1 mbox client. Clients in multiple drivers need the callbacks to either know when to start polling, or be notified when the transaction is complete. It would be nice if multiple clients could use the same channel.
>>
> We had to choose from shared vs exclusive access to channels... latter
> was chosen because there are ways to still support former.

This makes more sense now. Thanks for clarifying.

Jon
