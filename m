From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 10:01:55 +0100
Subject: [PATCH v6 13/21] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <1452209679-19445-14-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-14-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <7056596.KRbB42JIuZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:31 Yury Norov wrote:
> +long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
> +                       compat_ulong_t caddr, compat_ulong_t cdata)
> +{
> +       if (is_a32_compat_task())
> +               return compat_a32_ptrace(child, request, caddr, cdata);
> +
> +       return compat_ptrace_request(child, request, caddr, cdata);
> +}
> +

Looking at this again, I think we can avoid this runtime check
if we duplicate the compat_sys_ptrace function and make a special one
for a32 that is copied from the regular handler and but calls
compat_a32_ptrace directly. Or maybe make a separate handler for
arm64-ilp32 if that is smaller.

	Arnd
