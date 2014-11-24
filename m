From: ghackmann@google.com (Greg Hackmann)
Date: Mon, 24 Nov 2014 12:58:33 -0800
Subject: [PATCH v5 3/6] arm64: Add framework for legacy instruction
 emulation
In-Reply-To: <1416310887-14649-4-git-send-email-punit.agrawal@arm.com>
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
 <1416310887-14649-4-git-send-email-punit.agrawal@arm.com>
Message-ID: <CAJKQeMZE_akWY39U3X3a1_-co3da2H03kUkOsZ_5CLrwMn-=wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If it's not too late to chime in, I ran across one issue testing this patchset:

On Tue, Nov 18, 2014 at 3:41 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> +       ret = update_insn_emulation_mode(insn, prev_mode);
> +       if (!ret) {
> +               /* Mode change failed, revert to previous mode. */
> +               insn->current_mode = prev_mode;
> +               update_insn_emulation_mode(insn, INSN_UNDEF);
> +       }

update_insn_emulation_mode() returns 0 on success, so the condition
needs to be "if (ret)".  Otherwise writes to the sysctl file are
immediately rolled back.
