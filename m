From: danielwa@cisco.com (Daniel Walker)
Date: Tue, 20 Oct 2015 12:54:52 -0700
Subject: [PATCH-RFC 5/7] arm: convert to generic builtin command line
In-Reply-To: <CAL_Jsq+qF5DNqQYyL2pAeCX=+1xb6p7bY2SUoi4Mm1YrMtQTLA@mail.gmail.com>
References: <1444146434-12776-5-git-send-email-danielwa@cisco.com>
 <CAL_Jsq+qF5DNqQYyL2pAeCX=+1xb6p7bY2SUoi4Mm1YrMtQTLA@mail.gmail.com>
Message-ID: <56269C0C.3030400@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 02:48 PM, Rob Herring wrote:
>>   #ifndef MEM_SIZE
>> >  #define MEM_SIZE       (16*1024*1024)
>> >@@ -125,16 +126,9 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
>> >
>> >  static int __init parse_tag_cmdline(const struct tag *tag)
>> >  {
>> >-#if defined(CONFIG_CMDLINE_EXTEND)
>> >-       strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
>> >         strlcat(default_command_line, tag->u.cmdline.cmdline,
>> >                 COMMAND_LINE_SIZE);
> Just do this here:
>
> cmdline_add_builtin(boot_command_line, tag->u.cmdline.cmdline,
> COMMAND_LINE_SIZE);
>
> and remove everything from setup_machine_tags.
>
> Also, I don't think there is any reason to have cmd_line and copy
> boot_command_line to it in setup.c.
>

I don't think this function runs if there's no cmdline atag, so if the 
code is here then without a atag for cmdline you wouldn't get the 
builtin command line either which I don't think make sense. We should 
get the builtin regardless of this atag appearing, or if there's a DT 
bootargs.

Daniel
