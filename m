From: roger.pau@citrix.com (=?UTF-8?Q?Roger_Pau_Monn=c3=a9?=)
Date: Mon, 14 Sep 2015 16:29:48 +0200
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6C1D2.7010206@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
Message-ID: <55F6D9DC.8060607@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

El 14/09/15 a les 14.47, Julien Grall ha escrit:
> On 14/09/15 13:08, Roger Pau Monn? wrote:
>>> I'd like to see a basic support of 64KB page granularity upstream before
>>> starting to think about performance improvement. And there is still a
>>> lot to do.
>>
>> I wasn't actually thinking of this as a performance improvement, but
>> rather as a way of fixing this properly and removing the complexity
>> added to xen-blkfront, thus providing a PV block protocol that natively
>> supports 64KB pages. This would be like hardware components already do
>> AFAIK, because I don't think there are other drivers in the Linux tree
>> that do this kind of splitting.
>>
>>> Although, having 64KB grants won't remove the splitting as we would
>>> still have to support frontend/backend which only handle 4KB grant.
>>
>> IMHO, given enough time I would just drop those.
> 
> The PV protocol has always been backward compatible.
> 
> Introducing the support of 64KB grant will require some changes in Xen
> which won't surely be backported to older version. We still have to be
> able to run new Linux guest on older Xen and vice versa.

OK, so let's wait a couple of Xen and Linux releases before dropping
this from the Linux kernel once 64KB grant support is added. Guests
should still be able to boot, it's just the disk that won't be attached.

IMHO this splitting is just a workaround for the fact that we don't have
a 64KB PV block protocol, and this is the real problem that should be
solved.

In the long term this will put a burden on all blkfronts (if 64KB pages
are also used by other OSes), while introducing a 64KB PV block protocol
will make the blkfront implementation in all OSes very similar to what
we have now, without replicating the splitting code amongst all the
possible blkfront implementations.

Granted that some changes to blkback will be needed in order to support
mapping 64KB grants, but there are much fewer blkback implementations
out there than blkfronts.

> To give you an example, Centos 7, which will support Xen and only 64KB
> page granularity, will be supported for years. Dropping any splitting in
> a short future (3-5 years) will just break those guests to boot on Xen.

Can't the patches to support 64KB grants be backported to CentOS? In the
past you said that distros had no problem in picking the needed Xen
patches for 64KB support, I don't see how that would be different.

Also, a blkfront with the splitting code should also be able to work
perfectly fine once we have a 64KB PV block protocol, it will just be
treated like it's using 4KB pages, that's all.

> AFAIK, we never took a such radical decision on Xen based on the
> complexity of the code.

We never had to deal with a problem like this I'm afraid (mixing guests
with different page sizes), so I don't think we can make statements
about that.

And it's not just about the complexity, it's because as stated above
this IMHO is just sweeping the real problem under the carpet instead of
solving it.

Roger.
