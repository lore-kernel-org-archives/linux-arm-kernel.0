From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 6 Aug 2012 17:16:18 +0300
Subject: [PATCH 1/1] remoteproc: extend customized fw loader to cover
 request and release
In-Reply-To: <1344237865-32491-1-git-send-email-roylee17@gmail.com>
References: <1344237865-32491-1-git-send-email-roylee17@gmail.com>
Message-ID: <CAK=WgbbBHspN_LTUXH1kUugH8-Nr-G=p-G3Wj60tAmrqqfakmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tzu-Jung Lee,

On Mon, Aug 6, 2012 at 10:24 AM, Tzu-Jung Lee <roylee17@gmail.com> wrote:
> Previously, the remoteproc mandates an actual ELF firmware in order to
> parse the resource table and boot the remoteproc.
>
> An fw loader abstraction was added in v3.61-rc1 to make the ELF as a
> "default" handler, and allows firmwares in other formats to be loaded.
>
> However, in our use cases, we don't actually have a firmware for linux
> to load. The remote processor always boots first, and then boots the
> rest of processors that running linux.

Can you describe your use case some more ?

What parts in remoteproc are actually helpful for you (not much I
guess if Linux doesn't control the life cycle of the remote processor
in your case) ?

Do you use rpmsg ?

> In this case, forging an binary firmware just for the resource table
> creates a burden for maintenence.
> Allowing the firmware request/release function to be customized gives
> developers to construct the reqource table in memory, instead of loading
> one from filesystem.

I'm not sure this is an ideal abstraction though.

The problem you describe is architectural and not necessarily related
with a specific binary format, which this patch ties it up with (by
abstracting it away in rproc_fw_ops). It seems that a
binary-format-agnostic solution is preferable, because it could then
be utilized by any platform, regardless of the binary format it uses.

In general we prefer not to adopt a solution that puts the resource
table in the kernel, because that means redundant churn and
compatibility issues, as the resource table is inherently coupled with
the software running on the remote processor, and not with the Linux
kernel.

An easy solution is to allow loading an external stand-alone resource
table from the filesystem. We've discussed this in the past and
several parties showed interest. Will it help you ?

Another possible solution is to allow the low level rproc driver to
provide the remoteproc framework a pointer to an in-memory resource
table. This may prove useful in case the remote processor is already
up when Linux boots, and the resource table is already loaded to
memory.

> Change-Id: I0aa071dc1bd775eed6ea0822cff0fe2fc1b12b45

PS - no need to provide these tags when sending patches upstream.

Thanks,
Ohad.
