From: dvyukov@google.com (Dmitry Vyukov)
Date: Tue, 19 Jan 2016 15:02:17 +0100
Subject: [PATCH v4] kernel: add kcov code coverage
In-Reply-To: <20160119130543.GB20984@node.shutemov.name>
References: <1453145117-92868-1-git-send-email-dvyukov@google.com>
 <20160118225550.GE14531@node.shutemov.name>
 <CACT4Y+ZUKJOmATAASxM1qnbn=_0M9TAtTQYO0ecMtursLYvdww@mail.gmail.com>
 <20160119130543.GB20984@node.shutemov.name>
Message-ID: <CACT4Y+Z9OSwhV3CMhKg+b0wrwvh6f8f-Kgj_xumjKAtkL=YcBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 2:05 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Tue, Jan 19, 2016 at 01:55:43PM +0100, Dmitry Vyukov wrote:
>> >> +static int __init kcov_init(void)
>> >> +{
>> >> +     if (!debugfs_create_file("kcov", 0666, NULL, NULL, &kcov_fops)) {
>> >
>> > Why 0666? May be 0600?.
>>
>> The idea is that it can be useful to fuzz-test under a normal user as well.
>> This file is also guarded by debugfs mount permissions. Usually it is mounted
>> as 0700, so normal users can't get access to it.
>> However if one wants to fuzz-test under a normal user, he could mount
>> debugfs as 0777 and get access to this file.
>>
>> I am not very strong about this, though. If you say, I will change it to 0600.
>> I open this file as root at the moment. And we can change it back
>> if/when we better understand a potential use case.
>
> I think it's safer to make it 0600. It's up to system administrator to
> change permissions, if he wants give this capability to mortals.

Great! I've missed the possibility of chmoding it afterwards. Will
change to 0600 in next version.
