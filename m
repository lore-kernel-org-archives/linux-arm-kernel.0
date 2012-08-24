From: dgreid@chromium.org (Dylan Reid)
Date: Fri, 24 Aug 2012 00:52:10 -0700
Subject: [alsa-devel] [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
In-Reply-To: <00df01cd81cb$e21d2f00$a6578d00$@com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
Message-ID: <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 12:41 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> Hi!
>
> On Thu, Aug 24, 2012 at 5:51 AM, Dylan Reid wrote:
>> On suspend all dma transactions are terminated (by the stop/suspend
>> trigger calling ops->stop), they need to be set up again during resume.
>> Move the prepare op to the start/resume/unpause trigger path so that dma
>> and audio will restart on resume/unpause.
> Do you mean that currently, suspend/resume can't be supported?

Yes. Currently, if I suspend while playing, after resume it won't work
until I close and reopen the device.  the call to snd_pcm_resume is
not indicating an error, but a write error comes from snd_pcm_write a
little later.

The suspend trigger calls ops->stop, which in turn sends
DMA_TERMINATE_ALL to the pl330.  I think this causes resume's call to
ops->trigger to fail because there is nothing enqueued, but I'm pretty
new to this system.

Thanks for the help!

Dylan

>
> Thanks,
> Sangbeom.
>
