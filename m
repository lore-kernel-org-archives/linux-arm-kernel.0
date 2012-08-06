From: roylee17@gmail.com (Tzu-Jung Lee)
Date: Tue, 7 Aug 2012 00:43:12 +0800
Subject: [PATCH 1/1] remoteproc: extend customized fw loader to cover
 request and release
In-Reply-To: <CAK=WgbbBHspN_LTUXH1kUugH8-Nr-G=p-G3Wj60tAmrqqfakmg@mail.gmail.com>
References: <1344237865-32491-1-git-send-email-roylee17@gmail.com>
 <CAK=WgbbBHspN_LTUXH1kUugH8-Nr-G=p-G3Wj60tAmrqqfakmg@mail.gmail.com>
Message-ID: <CAEvN+1h5dVxX74YtBNwjiqzZNrpK56jBw9TaJjszf_-E3DY2gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Mon, Aug 6, 2012 at 10:16 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Tzu-Jung Lee,
>
> On Mon, Aug 6, 2012 at 10:24 AM, Tzu-Jung Lee <roylee17@gmail.com> wrote:
>> Previously, the remoteproc mandates an actual ELF firmware in order to
>> parse the resource table and boot the remoteproc.
>>
>> An fw loader abstraction was added in v3.61-rc1 to make the ELF as a
>> "default" handler, and allows firmwares in other formats to be loaded.
>>
>> However, in our use cases, we don't actually have a firmware for linux
>> to load. The remote processor always boots first, and then boots the
>> rest of processors that running linux.
>
> Can you describe your use case some more ?

It's three processors AMP SoC, the first powered on processors runs
 an RTOS and boots up the other two which run linux.

> What parts in remoteproc are actually helpful for you (not much I
> guess if Linux doesn't control the life cycle of the remote processor
> in your case) ?
>
> Do you use rpmsg ?

Yes, I'm using rpmsg.
And actually the remoteproc provides a good abstraction and the generic
facilities sysfs/debugfs handling, resource format, vring allocation, etc...
And the start/stop/kick API also serves as good place for handshaking
with the remote processors. Overall, most of the framework works well with
our platform, and the difference can be hidden in the platform priv
data structure.

>> In this case, forging an binary firmware just for the resource table
>> creates a burden for maintenence.
>> Allowing the firmware request/release function to be customized gives
>> developers to construct the reqource table in memory, instead of loading
>> one from filesystem.
>
> I'm not sure this is an ideal abstraction though.

Agree.
The patch may not solve this, but it should address some issues I'm having.

> The problem you describe is architectural and not necessarily related
> with a specific binary format, which this patch ties it up with (by
> abstracting it away in rproc_fw_ops). It seems that a
> binary-format-agnostic solution is preferable, because it could then
> be utilized by any platform, regardless of the binary format it uses.

> In general we prefer not to adopt a solution that puts the resource
> table in the kernel, because that means redundant churn and
> compatibility issues, as the resource table is inherently coupled with
> the software running on the remote processor, and not with the Linux
> kernel.

Yes, that's the point.

The format issue has been addressed by the fw format handler.
But we still need to address where the data come from.
Even it is in ELF format, it may not necessarily come from root file system.
It can be loaded from MTD partition or constructed/derived from the cmdline.

> An easy solution is to allow loading an external stand-alone resource
> table from the filesystem. We've discussed this in the past and
> several parties showed interest. Will it help you ?

Actually, I've been using the this approach for the past few weeks.
I forged an ELF file containing the resource table, and dummy loadable
sections, otherwise it  failed the sanity checks. Until yesterday I merged
and found the fw format handler support in v3.6-rc1, and wondered if we
can just extend it a little bit to not load (bypass) the firmware at all.

> Another possible solution is to allow the low level rproc driver to
> provide the remoteproc framework a pointer to an in-memory resource
> table. This may prove useful in case the remote processor is already
> up when Linux boots, and the resource table is already loaded to
> memory.

That's what I'm trying to do, and it has two things needs to be address.

  1)  Make the firmware loading step "optional" in the booting process.

  2)  Allow the remoteproc use an customized handler to get the resource table.

Thanks,
Roy
