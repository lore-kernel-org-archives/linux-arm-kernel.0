From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 18 Jan 2016 01:23:50 -0600
Subject: [RFC] arm64: failed when run the command: timedatectl set-timezone
 Asia/Shanghai
In-Reply-To: <20160113110900.GA23370@leverpostej>
References: <56946932.70601@huawei.com> <569473B2.3030909@huawei.com>
 <CAPvkgC3HkZ5nP4qxDO+LRCeK5dd29zEpz9ZeK7J_mrCWXrszGA@mail.gmail.com>
 <5695A57B.1060905@huawei.com> <20160113110900.GA23370@leverpostej>
Message-ID: <569C9306.7090904@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Xishi,

On 1/13/16, 5:09 AM, Mark Rutland wrote:
> On Wed, Jan 13, 2016 at 09:16:43AM +0800, Xishi Qiu wrote:
>> On 2016/1/12 18:59, Steve Capper wrote:
>>
>>> On 12 January 2016 at 03:32, Xishi Qiu <qiuxishi@huawei.com> wrote:
>>>> On 2016/1/12 10:47, Xishi Qiu wrote:
>>>>
>>>>> Failed when run the command: timedatectl set-timezone Asia/Shanghai
>>>>> But CONFIG_PGTABLE_LEVELS=3 is OK, and CONFIG_PGTABLE_LEVELS=4 is failed.
>>>>> The kernel is v4.1, and this command need the lib polikit.
>>>>>
>>>>> Is this the bug of kernel?

As noted by others, this is a problem with interpretation by certain 
userspace (probably not restricted to mozjs) applications of their 
ability to use the high order bits of a VA. It's actually been flagged a 
few times by others in both RHEL(SA) and Fedora as well, but I've 
pointed out (at least in the former) that we're not building with a 
48-bit VA currently so it won't be as visible for the moment. That means 
if you're consuming a Cent7 kernel from Jim/etc. it'll probably not fall 
over out of the box (copying him so he knows about this - it's been 
coming up a bit over the past few days in some other conversation).

This definitely needs fixing in upstream polkit builds, and a general 
education exercise needs to be initiated so that people don't get this 
wrong in future (but it's guaranteed that they will). FWIW my personal 
opinion is that tagged pointers are dangerous and should never have 
happened (because you can't trust people/there will be code out there 
for years that will have broken assumptions and never be fixed).

Jon.
