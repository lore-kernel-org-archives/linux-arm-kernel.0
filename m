From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 28 Aug 2014 00:56:35 +0530
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <CAL1qeaERHeKKNpqh9qHOppgT7ymvntisdjVvZheP78U6NaPz-A@mail.gmail.com>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-3-git-send-email-abrestic@chromium.org>
 <53FB8820.4010202@wwwdotorg.org>
 <CAL1qeaERHeKKNpqh9qHOppgT7ymvntisdjVvZheP78U6NaPz-A@mail.gmail.com>
Message-ID: <CAJe_ZhexxKSDfJeojY5FETdzvnA6082mcXjpfQ-oaMNRTN=-Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2014 23:08, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Mon, Aug 25, 2014 at 12:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> I'm not even sure if it's appropriate for the low-level mailbox driver to
>> know about the semantics of the message, rather than simply sending them on
>> to the client driver? Perhaps when drivers register(?) for callbacks(?) for
>> messages, they should state which types of messages they want to listen to?
>
> So there's not really a way for the client driver to tell the mailbox
> driver which types of messages it wants to listen to on a particular
> channel with the mailbox framework - it simply provides a way for
> clients to bind with channels.  I think there are a couple of options
> here, either: a) have a channel per message (as you mentioned in the
> previous patch), which allows the client to only register for messages
> (channels) it wants to handle, or b) extend the mailbox framework to
> allow shared channels so that both clients can receive messages on the
> single channel and handle messages appropriately.   The disadvantage
> of (a) is that the commands are firmware defined and could
> theoretically change between releases of the firmware, though I'm not
> sure how common that is in practice.  So that leaves (b) - Jassi, what
> do you think about having shared (non-exclusive) channels?
>
n++ ... 'mailbox' is one such device that imbibes properties of local
controller hardware and the remote firmware. Change in remote f/w's
behavior might require the controller driver to change besides our
client driver. A typical example is format of payloads (if
involved).... a client and mailbox controller driver have direct
understanding of the packet format ... which is likely to change with
remote f/w.  So if the original concern "why are we doing s/w protocol
stuff in controller driver?" won't go away by providing for shared
channels (which would have its own tradeoffs).

BTW, on DMAEngine we are moving towards virtual channels backed by
limited physical ones ... your setup looks quite similar. So your
demuxer doesn't hurt my eyes at all.

-jassi
